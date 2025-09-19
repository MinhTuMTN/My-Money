import 'package:dio/dio.dart';
import 'package:my_money/core/service/token_service.dart';
import 'package:my_money/service_locator.dart';

class ApiInterceptor extends QueuedInterceptor {
  final TokenService _tokenService = getIt.get<TokenService>();
  final Dio dio;

  final List<String> noAuthPath = [
    '/auth/login',
    '/auth/check-token',
  ];


  ApiInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!noAuthPath.contains(options.path)) {
      options.headers['Authorization'] = 'Bearer ${_tokenService.getAuthToken()}';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final token = await _tokenService.getRefreshToken();
    if (token == null || token.isEmpty) {
      return handler.next(err);
    }

    final isTokenRefreshed = await refreshToken(token);
    if (!isTokenRefreshed) {
      return handler.next(err);
    }

    try {
      // Thử lại yêu cầu ban đầu với token mới
      final response = await _retry(err.requestOptions);
      // Trả về response mới, các yêu cầu đang chờ sẽ được tiếp tục
      return handler.resolve(response);
    } on DioException catch (e) {
      // Nếu thử lại vẫn lỗi, trả về lỗi đó
      return handler.next(e);
    }
  }

  Future<bool> refreshToken(String token) async {
    try {
      // Sử dụng một instance Dio riêng để tránh vòng lặp interceptor vô hạn
      final refreshTokenDio = Dio();
      final response = await refreshTokenDio.post(
        'https://api.example.com/refreshToken', // ĐÂY LÀ ENDPOINT REFRESH TOKEN CỦA BẠN
        data: {'refreshToken': token},
      );

      if (response.statusCode == 200) {
        // Giả sử API trả về access token và refresh token mới
        final accessToken = response.data['data']['accessToken']['token'];
        final refreshToken = response.data['data']['refreshToken']['token'];
        await _tokenService.saveAuthToken(accessToken);
        await _tokenService.saveRefreshToken(refreshToken);
        return true;
      }
    } catch (e) {
      await _tokenService.deleteAuthToken();
      await _tokenService.deleteRefreshToken();
    }
    return false;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    String? accessToken = await _tokenService.getAuthToken();

    final options = Options(
      method: requestOptions.method,
      headers: {
        'Authorization': 'Bearer $accessToken',
        ...requestOptions.headers
          ..remove('Authorization'), // Xóa header cũ nếu có
      },
    );

    // Thực hiện lại yêu cầu với token mới
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}

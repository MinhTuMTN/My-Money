import 'package:dio/dio.dart';
import 'package:my_money/core/interceptor/api_interceptor.dart';

class ApiService {
  final Dio _dio;
  static const baseUrl = 'http://165.154.205.156:8080';

  ApiService() : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      validateStatus: (status) {
        if (status == null) {
          return false;
        }
        return status >= 200;
      }
    ),
  ) {
    _dio.interceptors.add(ApiInterceptor(dio: _dio));
  }


  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }
}
import 'package:flutter/material.dart';
import 'package:my_money/core/service/api_service.dart';
import 'package:my_money/core/service/token_service.dart';
import 'package:my_money/service_locator.dart';

class AuthService extends ChangeNotifier {
  final TokenService _tokenService;
  final ApiService _apiService = getIt.get<ApiService>();

  AuthService(this._tokenService);

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    _isLoggedIn = await checkToken();
    _isLoading = false;

    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    final response = await _apiService.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final accessToken = response.data['data']['accessToken']['token'];
      final refreshToken = response.data['data']['refreshToken']['token'];
      await _tokenService.saveAuthToken(accessToken);
      await _tokenService.saveRefreshToken(refreshToken);
      _isLoggedIn = true;
      notifyListeners();
      return null;
    } else {
      String message = response.data['message'];
      return message;
    }
  }

  Future<bool> checkToken() async {
    final refreshToken = await _tokenService.getRefreshToken();

    if (refreshToken == null) {
      return false;
    }

    final response = await _apiService.post(
      '/auth/check-token',
      data: {'token': refreshToken},
    );

    if (response.statusCode != 200) {
      return false;
    }

    return response.data['data'];
  }

  void logout() async {
    await _tokenService.deleteAuthToken();
    await _tokenService.deleteRefreshToken();
    _isLoggedIn = false;
    notifyListeners();
  }
}

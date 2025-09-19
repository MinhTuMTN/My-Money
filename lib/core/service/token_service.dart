import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _secureStorage;

  TokenService(this._secureStorage);

  Future<void> saveAuthToken(String token) async {
    _secureStorage.write(key: _authTokenKey, value: token);
  }

  Future<String?> getAuthToken() async {
    return _secureStorage.read(key: _authTokenKey);
  }

  Future<void> deleteAuthToken() async {
    _secureStorage.delete(key: _authTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> deleteRefreshToken() async {
    _secureStorage.delete(key: _refreshTokenKey);
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for secure local storage (tokens, sensitive data)
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  /// Save authentication token
  Future<void> saveToken(String token) => _storage.write(
        key: _tokenKey,
        value: token,
      );

  /// Get authentication token
  Future<String?> getToken() => _storage.read(key: _tokenKey);

  /// Save refresh token
  Future<void> saveRefreshToken(String token) => _storage.write(
        key: _refreshTokenKey,
        value: token,
      );

  /// Get refresh token
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  /// Clear all tokens
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  /// Check if token exists
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }
}

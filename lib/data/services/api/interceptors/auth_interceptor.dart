import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';

/// HTTP interceptor that adds authentication token to requests
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required SecureStorageService storage}) : _storage = storage;

  final SecureStorageService _storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Handle unauthorized - clear token and trigger logout
      await _storage.clearToken();
      _onUnauthorized?.call();
    }
    return handler.next(err);
  }

  /// Callback when session expires (401)
  Function()? _onUnauthorized;

  /// Set unauthorized callback
  void setOnUnauthorized(Function() callback) {
    _onUnauthorized = callback;
  }
}

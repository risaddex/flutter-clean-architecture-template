import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_template/config/environment.dart';

/// HTTP client factory
/// Creates and configures Dio instance with interceptors
class ApiClient {
  static Dio create({
    required List<Interceptor> interceptors,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Environment.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );

    // Add custom interceptors
    for (final interceptor in interceptors) {
      dio.interceptors.add(interceptor);
    }

    return dio;
  }
}

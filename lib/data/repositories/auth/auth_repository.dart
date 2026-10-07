import 'package:flutter_clean_architecture_template/core/result.dart';
import 'package:flutter_clean_architecture_template/domain/models/auth_session.dart';

/// Auth repository interface
/// Implement for local or remote data sources
abstract interface class AuthRepository {
  /// Login with email and password
  /// Returns AuthSession on success
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  });

  /// Register new user
  Future<Result<void>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Logout current user
  Future<Result<void>> logout();
}

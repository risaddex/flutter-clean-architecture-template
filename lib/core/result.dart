import 'package:flutter_clean_architecture_template/core/exceptions/app_exception.dart';

/// Result type for handling success and error cases without exceptions
/// Usage: Future<Result<User>> fetchUser() => Result.ok(user) or Result.error(exception)
sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;
  const factory Result.error(AppException error) = Error._;

  static const Result<void> done = Ok<void>._(null);

  /// Pattern matching for Result
  R fold<R>(
    R Function(T value) onOk,
    R Function(AppException error) onError,
  ) {
    return switch (this) {
      Ok(:final value) => onOk(value),
      Error(:final error) => onError(error),
    };
  }

  /// Get value or null
  T? get valueOrNull => fold((v) => v, (_) => null);

  /// Get error or null
  AppException? get errorOrNull => fold((_) => null, (e) => e);

  /// Check if result is success
  bool get isOk => this is Ok<T>;

  /// Check if result is error
  bool get isError => this is Error<T>;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);
  final T value;
}

final class Error<T> extends Result<T> {
  const Error._(this.error);
  final AppException error;
}

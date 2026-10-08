import 'package:flutter_clean_architecture_template/core/exceptions/app_exception.dart';

sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>._;
  const factory Result.error(AppException error) = Error<T>._;

  static const Result<void> done = Ok<void>._(null);

  R fold<R>(R Function(T value) onOk, R Function(AppException error) onError) {
    return switch (this) {
      Ok<T>(:final value) => onOk(value),
      Error<T>(:final error) => onError(error),
    };
  }
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);
  final T value;
}

final class Error<T> extends Result<T> {
  const Error._(this.error);
  final AppException error;
}

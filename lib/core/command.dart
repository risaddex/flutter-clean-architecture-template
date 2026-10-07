import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture_template/core/result.dart';

/// Command pattern for handling async operations with loading and result states
/// Usage: await command.execute() with automatic loading/error/success state management
typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

abstract base class Command<T> extends ChangeNotifier {
  bool _running = false;
  Result<T>? _result;

  bool get running => _running;
  bool get hasError => _result is Error;
  bool get isComplete => _result is Ok;
  Result<T>? get result => _result;

  /// Clear previous result
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  /// Execute async action with automatic state management
  Future<void> _execute(CommandAction0<T> action) async {
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// Command with no arguments
class Command0<T> extends Command<T> {
  Command0(this._action);
  final CommandAction0<T> _action;

  Future<void> execute() => _execute(_action);
}

/// Command with one argument
class Command1<T, A> extends Command<T> {
  Command1(this._action);
  final CommandAction1<T, A> _action;

  Future<void> execute(A argument) => _execute(() => _action(argument));
}

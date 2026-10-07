import 'package:flutter/foundation.dart';

import 'package:flutter_clean_architecture_template/core/command.dart';
import 'package:flutter_clean_architecture_template/core/exceptions/app_exception.dart';
import 'package:flutter_clean_architecture_template/core/result.dart';
import 'package:flutter_clean_architecture_template/core/view_model_initializable.dart';
import 'package:flutter_clean_architecture_template/domain/models/auth_session.dart';
import 'package:flutter_clean_architecture_template/domain/use_cases/auth/login_use_case.dart';

class LoginViewModel extends ChangeNotifier implements ViewModelInitializable {
  LoginViewModel({
    required LoginUseCase loginUseCase,
  }) : _loginUseCase = loginUseCase;

  final LoginUseCase _loginUseCase;

  final Command0<AuthSession> _loginCommand = Command0((_) async {
    throw UnimplementedError('Use login() method instead');
  });

  bool _isBusy = false;
  AppException? _error;
  AuthSession? _session;

  bool get isBusy => _isBusy;
  AppException? get error => _error;
  AuthSession? get session => _session;

  @override
  void init() {
    _isBusy = false;
    _error = null;
    _session = null;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _isBusy = true;
    _error = null;
    notifyListeners();

    final result = await _loginUseCase(
      email: email,
      password: password,
    );

    switch (result) {
      case Ok<AuthSession>(:final value):
        _session = value;
      case Error<AuthSession>(:final error):
        _error = error;
    }

    _isBusy = false;
    notifyListeners();
  }
}

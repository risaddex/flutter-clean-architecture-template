import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:flutter_clean_architecture_template/data/repositories/auth/auth_repository.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';
import 'package:flutter_clean_architecture_template/domain/use_cases/auth/login_use_case.dart';
import 'package:flutter_clean_architecture_template/ui/auth/login/login_viewmodel.dart';

class LoginBindings extends StatelessWidget {
  const LoginBindings({
    super.key,
    required this.screenBuilder,
  });

  final WidgetBuilder screenBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => LoginUseCase(
            authRepository: context.read<AuthRepository>(),
            storage: context.read<SecureStorageService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(
            loginUseCase: context.read<LoginUseCase>(),
          ).initialized(),
        ),
      ],
      builder: (_, __) => screenBuilder(context),
    );
  }
}

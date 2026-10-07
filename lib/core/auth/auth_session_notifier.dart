import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_clean_architecture_template/config/environment.dart';
import 'package:flutter_clean_architecture_template/core/auth/auth_session_notifier.dart';
import 'package:flutter_clean_architecture_template/data/repositories/auth/auth_repository.dart';
import 'package:flutter_clean_architecture_template/data/services/api/api_client.dart';
import 'package:flutter_clean_architecture_template/data/services/api/interceptors/auth_interceptor.dart';
import 'package:flutter_clean_architecture_template/data/services/local/secure_storage_service.dart';
import 'package:flutter_clean_architecture_template/routing/app_router.dart';

/// Global dependency registration for the app.
class ApplicationBindings extends StatelessWidget {
  const ApplicationBindings({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final storage = SecureStorageService();
    final authInterceptor = AuthInterceptor(storage: storage);

    final dio = ApiClient.create(interceptors: [authInterceptor]);

    return MultiProvider(
      providers: [
        Provider<SecureStorageService>.value(value: storage),
        Provider<Dio>.value(value: dio),
        Provider<AuthInterceptor>.value(value: authInterceptor),
        ChangeNotifierProvider(
          create: (_) => AuthSessionNotifier(storage: storage),
        ),
        Provider<GoRouter>(
          create: (_) => buildRouter(context.read<AuthSessionNotifier>()),
        ),
      ],
      child: child,
    );
  }
}

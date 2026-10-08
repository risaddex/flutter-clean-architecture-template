import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architecture_template/core/auth/auth_session_notifier.dart';
import 'package:flutter_clean_architecture_template/routing/routes.dart';
import 'package:flutter_clean_architecture_template/ui/home/home_screen.dart';
import 'package:flutter_clean_architecture_template/ui/splash/splash_screen.dart';

GoRouter buildRouter(AuthSessionNotifier sessionNotifier) {
  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: sessionNotifier,
    redirect: (_, state) {
      final location = state.matchedLocation;
      if (location == Routes.splash) return null;
      if (!sessionNotifier.isRestored) return null;

      final isPublic = Routes.public.contains(location);
      if (!sessionNotifier.isSignedIn) {
        return isPublic ? null : Routes.login;
      }

      return isPublic ? Routes.home : null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => SplashScreen(sessionNotifier: sessionNotifier),
      ),
      GoRoute(
        path: Routes.login,
        builder: (_, __) => const Scaffold(body: Center(child: Text('Login screen placeholder'))),
      ),
      GoRoute(
        path: Routes.home,
        builder: (_, __) => const HomeScreen(),
      ),
    ],
  );
}

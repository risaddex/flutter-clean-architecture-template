final class Routes {
  Routes._();

  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static const String userPath = '/user/:id';
  static String user(String id) => '/user/$id';

  static const Set<String> public = {
    splash,
    welcome,
    login,
    register,
  };
}

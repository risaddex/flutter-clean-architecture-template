/// Application environment configuration
/// Update baseUrl based on build flavor (dev, staging, prod)
class Environment {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  static const bool isProduction = bool.fromEnvironment(
    'IS_PRODUCTION',
    defaultValue: false,
  );

  static const bool isDebug = bool.fromEnvironment(
    'IS_DEBUG',
    defaultValue: true,
  );
}

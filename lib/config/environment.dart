class Environment {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  static const bool isDebug = bool.fromEnvironment(
    'IS_DEBUG',
    defaultValue: true,
  );
}

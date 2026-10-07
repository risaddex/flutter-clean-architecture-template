/// Authentication session model
/// Represents user's authenticated session
class AuthSession {
  AuthSession({
    required this.userId,
    required this.email,
    required this.name,
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
  });

  final String userId;
  final String email;
  final String name;
  final String token;
  final String refreshToken;
  final DateTime expiresAt;

  /// Check if session is still valid
  bool get isValid => DateTime.now().isBefore(expiresAt);

  /// Check if session is expired
  bool get isExpired => !isValid;

  /// Time until expiration
  Duration get timeUntilExpiration => expiresAt.difference(DateTime.now());
}

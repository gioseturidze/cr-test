abstract class AppException implements Exception {
  String get message;

  const AppException();

  @override
  String toString() => message;
}

class InvalidCredentialsException extends AppException {
  @override
  final String message;
  const InvalidCredentialsException([this.message = 'Invalid credentials']);
}

class EmptyCredentialsException extends AppException {
  @override
  final String message;
  const EmptyCredentialsException([this.message = 'Username and password are required']);
}

class BiometricUnavailableException extends AppException {
  @override
  final String message;
  const BiometricUnavailableException([this.message = 'Biometric authentication is not available']);
}

class BiometricAuthFailedException extends AppException {
  @override
  final String message;
  const BiometricAuthFailedException([this.message = 'Biometric authentication failed']);
}

class SessionExpiredException extends AppException {
  @override
  final String message;
  const SessionExpiredException([this.message = 'Session expired']);
}

class GamesLoadException extends AppException {
  @override
  final String message;
  const GamesLoadException([this.message = 'Failed to load games']);
}

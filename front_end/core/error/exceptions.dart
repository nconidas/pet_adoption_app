class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class ServerException implements Exception {
  final String message;

  ServerException([this.message = '']);
}

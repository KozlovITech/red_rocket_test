abstract class AuthService {
  Future<AuthUser> login({required String email, required String password});
  Future<void> logout();
  Future<String?> currentToken();
}

class AuthUser {
  final String username;
  final String token;
  AuthUser(this.username, this.token);
}
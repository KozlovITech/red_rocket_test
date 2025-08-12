import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'auth_service.dart';

@LazySingleton(as: AuthService)
class MockAuthService implements AuthService {
  final FlutterSecureStorage _storage;
  MockAuthService(this._storage);

  static const _kToken = 'auth_token';

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final token = base64Url.encode(
      Hmac(sha256, utf8.encode('salt'))
          .convert(
            utf8.encode('$email|${DateTime.now().millisecondsSinceEpoch}'),
          )
          .bytes,
    );
    await _storage.write(key: _kToken, value: token);
    return AuthUser(email.split('@').first, token);
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _storage.delete(key: _kToken);
  }

  @override
  Future<String?> currentToken() => _storage.read(key: _kToken);
}

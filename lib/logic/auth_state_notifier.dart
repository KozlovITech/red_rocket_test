import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../data/auth/auth_service.dart';

@lazySingleton
class AuthStateNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> bootstrap(AuthService svc) async {
    final t = await svc.currentToken();
    _isLoggedIn = t != null && t.isNotEmpty;
    notifyListeners();
  }

  void setLoggedIn(bool v) {
    if (_isLoggedIn == v) return;
    _isLoggedIn = v;
    notifyListeners();
  }
}
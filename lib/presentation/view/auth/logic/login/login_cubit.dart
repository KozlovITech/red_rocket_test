import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/auth/auth_service.dart';
import '../../../../../logic/auth_state_notifier.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthService _auth;
  final AuthStateNotifier _authState;
  LoginCubit(this._auth, this._authState) : super(const LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      final user = await _auth.login(email: email, password: password);
      _authState.setLoggedIn(true);
      emit(state.copyWith(status: LoginStatus.success, user: user));
    } on Exception catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, error: e.toString()));
      emit(state.copyWith(status: LoginStatus.idle));
    }
  }
}

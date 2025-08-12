import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data/auth/auth_service.dart';
import '../../../../../logic/auth_state_notifier.dart';

part 'logout_state.dart';

@injectable
class LogoutCubit extends Cubit<LogoutState> {
  final AuthService _auth;
  final AuthStateNotifier _authState;

  LogoutCubit(this._auth, this._authState) : super(const LogoutState.initial());

  Future<void> logout() async {
    emit(state.copyWith(status: LogoutStatus.submitting));
    try {
      await _auth.logout();
      _authState.setLoggedIn(false);
      emit(const LogoutState.success());
    } on Exception catch (e) {
      emit(state.copyWith(status: LogoutStatus.failure, error: e.toString()));
    }
  }
}

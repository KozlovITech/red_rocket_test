part of 'login_cubit.dart';

enum LoginStatus { initial, idle, submitting, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? error;
  final AuthUser? user;

  const LoginState({required this.status, this.error, this.user});
  const LoginState.initial() : this(status: LoginStatus.initial);

  LoginState copyWith({LoginStatus? status, String? error, AuthUser? user}) =>
      LoginState(status: status ?? this.status, error: error, user: user);

  @override
  List<Object?> get props => [status, error, user];
}

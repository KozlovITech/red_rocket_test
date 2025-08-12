part of 'logout_cubit.dart';

enum LogoutStatus { initial, submitting, success, failure }

class LogoutState extends Equatable {
  final LogoutStatus status;
  final String? error;

  const LogoutState({required this.status, this.error});
  const LogoutState.initial() : this(status: LogoutStatus.initial);
  const LogoutState.success() : this(status: LogoutStatus.success);

  LogoutState copyWith({LogoutStatus? status, String? error}) =>
      LogoutState(status: status ?? this.status, error: error);

  @override
  List<Object?> get props => [status, error];
}
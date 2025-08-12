import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionCheckCubit extends Cubit<InternetStatus> {
  final InternetConnection _internetConnection;
  late final StreamSubscription<InternetStatus> _subscription;

  ConnectionCheckCubit(this._internetConnection)
      : super(InternetStatus.connected) {
    _subscription = _internetConnection.onStatusChange.listen(
          (status) {
        emit(status);
      },
      onError: (_, __) => emit(InternetStatus.disconnected),
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

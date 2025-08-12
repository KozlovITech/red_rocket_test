import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../logic/connection_check_cubit/connection_check_cubit.dart';
import '../view/error/view/error_connection_page.dart';

class ConnectivityWrapperWidget extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapperWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConnectionCheckCubit, InternetStatus>(
        builder: (context, state) {
          if (state == InternetStatus.disconnected) {
            return const ErrorConnectionPage();
          }
          return child;
        },
      ),
    );
  }
}

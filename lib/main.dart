import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/navigation/pages.dart';
import 'data/auth/auth_service.dart';
import 'di/injector.dart';
import 'logic/auth_state_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  configureDependencies();

  final svc = getIt<AuthService>();
  await getIt<AuthStateNotifier>().bootstrap(svc);

  final router = buildRouter();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) => EasyLocalization(
        supportedLocales: const [Locale('en', 'US')],
        path: 'assets/translates',
        fallbackLocale: const Locale('en', 'US'),
        child: App(router: router),
      ),
    ),
  );
}

part of 'pages.dart';

abstract class Routes {
  Routes._();

  static const splashRoute = '/${_Paths.splash}';
  static const authRoute = '/${_Paths.auth}';
  static const homeRoute = '/${_Paths.home}';

  static const errorRoute = '/${_Paths.error}';
  static const errorConnectionRoute = '/${_Paths.errorConnection}';
}

abstract class _Paths {
  static const splash = SplashPage.id;
  static const auth = AuthPage.id;
  static const home = HomePage.id;

  static const error = ErrorPage.id;
  static const errorConnection = ErrorConnectionPage.id;
}

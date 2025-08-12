import 'package:go_router/go_router.dart';
import '../../presentation/view/auth/view/auth_page.dart';
import '../../presentation/view/home/view/home_page.dart';

import '../../di/injector.dart';
import '../../logic/auth_state_notifier.dart';
import '../../presentation/view/error/view/error_connection_page.dart';
import '../../presentation/view/error/view/error_page.dart';
import '../../presentation/view/splash/view/splash_page.dart';

part 'routes.dart';

GoRouter buildRouter() {
  final authState = getIt<AuthStateNotifier>();

  return GoRouter(
    initialLocation: Routes.splashRoute,
    refreshListenable: authState,
    errorPageBuilder: (_, state) =>
        NoTransitionPage(key: state.pageKey, child: const ErrorPage()),
    routes: [
      GoRoute(path: '/', redirect: (_, _) => Routes.splashRoute),
      GoRoute(
        name: _Paths.splash,
        path: Routes.splashRoute,
        pageBuilder: (_, state) =>
            NoTransitionPage(key: state.pageKey, child: const SplashPage()),
      ),
      GoRoute(
        name: _Paths.auth,
        path: Routes.authRoute,
        pageBuilder: (_, state) =>
            NoTransitionPage(key: state.pageKey, child: const AuthPage()),
      ),
      GoRoute(
        name: _Paths.home,
        path: Routes.homeRoute,
        pageBuilder: (_, state) =>
            NoTransitionPage(key: state.pageKey, child: const HomePage()),
      ),

      GoRoute(
        name: _Paths.errorConnection,
        path: Routes.errorConnectionRoute,
        pageBuilder: (_, state) => NoTransitionPage(
          key: state.pageKey,
          child: const ErrorConnectionPage(),
        ),
      ),
    ],
    redirect: (ctx, s) {
      final loggedIn = authState.isLoggedIn;
      final atSplash = s.matchedLocation == Routes.splashRoute;
      final atAuth = s.matchedLocation == Routes.authRoute;
      final atHome = s.matchedLocation == Routes.homeRoute;

      if (atSplash) return loggedIn ? Routes.homeRoute : Routes.authRoute;

      if (!loggedIn && atHome) return Routes.authRoute;

      if (loggedIn && atAuth) return Routes.homeRoute;

      return null;
    },
  );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../di/injector.dart';
import '../logic/connection_check_cubit/connection_check_cubit.dart';
import '../presentation/common_widgets/connectivity_wraper_widget.dart';
import '../presentation/common_widgets/custom_loader.dart';
import '../presentation/view/auth/logic/login/login_cubit.dart';
import '../presentation/view/auth/logic/logout/logout_cubit.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_theme.dart';

class App extends StatelessWidget {
  final RouterConfig<Object> router;
  const App({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConnectionCheckCubit(InternetConnection())),
        BlocProvider(create: (_) => getIt<LoginCubit>()),
        BlocProvider(create: (_) => getIt<LogoutCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: AppDimens.designSize,
        child: GlobalLoaderOverlay(
          overlayWidgetBuilder: (_) => CustomLoader(), // 👈 важливо
          duration: const Duration(milliseconds: 100),
          reverseDuration: const Duration(milliseconds: 100),
          overlayColor: AppColors.white.withValues(alpha: 0.25),
          child: ConnectivityWrapperWidget(
            child: MaterialApp.router(
              theme: AppTheme.defaultTheme,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              routerConfig: router,
            ),
          ),
        ),
      ),
    );
  }
}

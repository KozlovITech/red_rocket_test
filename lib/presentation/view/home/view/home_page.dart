import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../common_widgets/buttons_widget.dart';
import '../../auth/logic/login/login_cubit.dart';
import '../../auth/logic/logout/logout_cubit.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = context.select(
      (LoginCubit c) => c.state.user?.username ?? 'User',
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.mainBG, AppColors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.size24,
            vertical: AppDimens.size16,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                color: AppColors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.borderRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.size20,
                    vertical: AppDimens.size24,
                  ),
                  child: BlocConsumer<LogoutCubit, LogoutState>(
                    listenWhen: (p, c) => p.status != c.status,
                    listener: (context, state) {

                      if (state.status == LogoutStatus.submitting) {
                        context.loaderOverlay.show();
                      } else {
                        context.loaderOverlay.hide();
                      }
                      if (state.status == LogoutStatus.failure &&
                          state.error != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error!)));
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ic_icon.svg',
                            height: AppDimens.size72,
                          ),
                          SizedBox(height: AppDimens.size20),

                          // title
                          Text(
                            'home_title'.tr(namedArgs: {'username': username}),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bold27,
                          ),
                          SizedBox(height: AppDimens.size6),

                          // subtitle
                          Text(
                            tr('home_subtitle'),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.normal14Grey,
                          ),

                          SizedBox(height: AppDimens.size24),

                          // primary action
                          MainDefaultButton(
                            label: tr('home_logout'),
                            action: () => context.read<LogoutCubit>().logout(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

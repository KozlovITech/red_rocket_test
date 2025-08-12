import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/pages.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../common_widgets/buttons_widget.dart';

import '../../../../theme/app_colors.dart';

class ErrorPage extends StatelessWidget {
  static const String id = 'error';

  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: AppDimens.size8),
                      Text(
                        'error.common_title'.tr(),
                        style: AppTextStyles.semiBold16.copyWith(
                          color: AppColors.lightBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimens.size12),
                      Text(
                        'error.common_subtitle'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mediumDarkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimens.size24),
                      MainDefaultButton(
                        label: 'error.button'.tr(),
                        action: () => context.go(Routes.splashRoute),
                      ),
                      SizedBox(height: AppDimens.size8),
                    ],
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

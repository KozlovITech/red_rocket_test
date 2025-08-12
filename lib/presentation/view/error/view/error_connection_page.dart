import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_dimens.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../common_widgets/buttons_widget.dart';

class ErrorConnectionPage extends StatelessWidget {
  static const String id = 'connection_error';

  const ErrorConnectionPage({super.key});

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
                        'error.connection_title'.tr(),
                        style: AppTextStyles.semiBold16.copyWith(
                          color: AppColors.lightBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimens.size12),
                      Text(
                        'error.connection_subtitle'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mediumDarkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimens.size24),
                      MainDefaultButton(
                        label: 'error.button'.tr(),
                        action: () => Navigator.of(context).pop(),
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

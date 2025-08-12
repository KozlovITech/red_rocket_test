import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../theme/app_text_styles.dart';

class MainDefaultButton extends StatelessWidget {
  final VoidCallback? action;
  final String label;
  final Color backgroundColor;
  final TextStyle? textStyles;

  const MainDefaultButton({
    super.key,
    required this.action,
    required this.label,
    this.backgroundColor = AppColors.mainBlue,
    this.textStyles,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          AppTextStyles.bold20White,
        ),
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.red),
        foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
        minimumSize: WidgetStateProperty.all<Size?>(
          Size(double.infinity, AppDimens.inputAndButtonHeight),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonBorderRadius),
          ),
        ),
      ),
      onPressed: action,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.size16),
        child: Text(label, style: textStyles ?? AppTextStyles.bold20White),
      ),
    );
  }
}

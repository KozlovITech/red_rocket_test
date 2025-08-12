import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildLightTheme();

  static ThemeData _buildLightTheme() {
    const radius = 16.0;

    final base = ThemeData.light(useMaterial3: true);

    const colorScheme = ColorScheme.light(
      primary: AppColors.mainBlue,
      secondary: AppColors.mainBlue,
      error: AppColors.red,
      onSurface: AppColors.lightBlack,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: AppColors.mainBlue,
      scaffoldBackgroundColor: AppColors.mainBG,

      textTheme: GoogleFonts.nunitoSansTextTheme().apply(
        bodyColor: AppColors.lightBlack,
        displayColor: AppColors.lightBlack,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.mainBG,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.nunitoSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.lightBlack,
        ),
        iconTheme: const IconThemeData(color: AppColors.lightBlack),
      ),

      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: const EdgeInsets.all(0),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        labelStyle: TextStyle(
          color: AppColors.lightBlack.withValues(alpha: .8),
        ),
        hintStyle: TextStyle(color: AppColors.lightBlack.withValues(alpha: .5)),
        errorStyle: const TextStyle(fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: AppColors.lightBlack.withValues(alpha: .15),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: AppColors.lightBlack.withValues(alpha: .15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.mainBlue, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: AppColors.red, width: 1.6),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: AppColors.mainBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          disabledBackgroundColor: AppColors.mainBlue.withValues(alpha: .35),
          disabledForegroundColor: Colors.white.withValues(alpha: .9),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.mainBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      dividerColor: AppColors.lightBlack.withValues(alpha: .1),
      splashColor: AppColors.mainBlue.withValues(alpha: .08),
      highlightColor: AppColors.mainBlue.withValues(alpha: .06),
    );
  }
}

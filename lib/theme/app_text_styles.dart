import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

sealed class AppTextStyles {
  static TextStyle bold27 = GoogleFonts.openSans(
    fontSize: 27,
    fontWeight: FontWeight.w800,
    height: 33 / 27,
    color: AppColors.lightBlack,
  );

  static TextStyle bold20 = GoogleFonts.openSans(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 24 / 20,
    color: AppColors.lightBlack,
  );

  static TextStyle bold20White = GoogleFonts.openSans(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 24 / 20,
    color: AppColors.white,
  );

  static TextStyle semiBold16 = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
    color: AppColors.lightBlack,
  );

  static TextStyle normal16Grey = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 22 / 16,
    color: AppColors.mediumDarkGray,
  );

  static TextStyle normal14 = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.lightBlack,
  );

  static TextStyle normal14Grey = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.mediumDarkGray,
  );

  static TextStyle bold12 = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    height: 16 / 12,
    color: AppColors.lightBlack,
  );
}

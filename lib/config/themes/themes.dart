import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

class Style {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kWhiteColor,
    useMaterial3: false,
    colorScheme: ThemeData().colorScheme.copyWith(
      primary: AppColors.kPrimaryColor,
      onPrimary: AppColors.kPrimaryColor,
      onSurface: AppColors.kPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kWhiteColor,
      elevation: 0,
      titleTextStyle: GoogleFonts.ibmPlexSansArabic(
        color: AppColors.kPrimaryColor,
        fontSize: 16.sp,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.kWhiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.ibmPlexSansArabic(color: AppColors.kBlackColor),
      bodyMedium: GoogleFonts.ibmPlexSansArabic(color: AppColors.kBlackColor),
      bodySmall: GoogleFonts.ibmPlexSansArabic(color: AppColors.kBlackColor),
      titleLarge: GoogleFonts.ibmPlexSansArabic(color: AppColors.kBlackColor),
      titleMedium: GoogleFonts.ibmPlexSansArabic(color: AppColors.kBlackColor),
      titleSmall: GoogleFonts.ibmPlexSansArabic(color: AppColors.kBlackColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.kBlackColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.kWhiteColor,
      selectedItemColor: AppColors.kBlackColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all(
          GoogleFonts.ibmPlexSansArabic(color: AppColors.kBlackColor),
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      headerBackgroundColor: AppColors.kBlackColor,
      todayBackgroundColor: MaterialStateProperty.all(AppColors.kBlackColor),
    ),
  );
}

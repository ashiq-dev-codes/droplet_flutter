import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Central Flutter theme matching the Figma fitness tracker design.
class AppTheme {
  static const String displayFont = 'Space Grotesk';
  static const String bodyFont = 'Inter';

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: bodyFont,
      scaffoldBackgroundColor: AppColors.background,
      splashFactory: NoSplash.splashFactory,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentOrange,
        secondary: AppColors.accentLime,
        surface: AppColors.background,
        onSurface: AppColors.ink,
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
        fontFamily: bodyFont,
      ),
    );
  }
}

/// Named text styles mirroring the Figma typography.
class AppTextStyles {
  static const TextStyle display = TextStyle(
    fontFamily: AppTheme.displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 34,
    height: 1.0,
    letterSpacing: -1.7,
    color: AppColors.ink,
  );

  static const TextStyle displayLarge = TextStyle(
    fontFamily: AppTheme.displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 84,
    height: 0.9,
    letterSpacing: -4.2,
    color: AppColors.ink,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: AppTheme.displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 30,
    height: 1.2,
    letterSpacing: -0.75,
    color: AppColors.ink,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: AppTheme.displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.4,
    color: AppColors.ink,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: AppTheme.displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.55,
    color: AppColors.ink,
  );

  static const TextStyle title = TextStyle(
    fontFamily: AppTheme.displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.25,
    color: AppColors.ink,
  );

  static const TextStyle body = TextStyle(
    fontFamily: AppTheme.bodyFont,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.4,
    color: AppColors.ink,
  );

  static const TextStyle bodySemi = TextStyle(
    fontFamily: AppTheme.bodyFont,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.4,
    color: AppColors.ink,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: AppTheme.bodyFont,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.5,
    color: AppColors.inkSoft,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: AppTheme.bodyFont,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 1.5,
    letterSpacing: 2.2,
    color: AppColors.inkSoft,
  );

  static const TextStyle microLabel = TextStyle(
    fontFamily: AppTheme.bodyFont,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.5,
    letterSpacing: 1.8,
    color: AppColors.inkSoft,
  );
}

import 'package:droplet_flutter/shared/theme/app_font.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Central Flutter theme matching the Figma fitness tracker design.
class AppTheme {
  // static const String AppFont.inter = 'Inter';
  // static const String displayFont = 'Space Grotesk';

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: AppFont.inter,
      scaffoldBackgroundColor: AppColors.background,
      splashFactory: NoSplash.splashFactory,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentOrange,
        secondary: AppColors.accentLime,
        surface: AppColors.background,
        onSurface: AppColors.textPrimary,
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
        fontFamily: AppFont.inter,
      ),
    );
  }
}

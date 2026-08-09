import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.cyan100, AppColors.whiteColor, AppColors.cyan50],
        ),
      ),
      child: child,
    );
  }
}

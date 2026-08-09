import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.1, 0.4, 0.5, 0.6, 0.7, 1],
            colors: [
              Color(0xFFCAEBF4),
              AppColors.whiteColor,
              AppColors.whiteColor,
              AppColors.whiteColor,
              AppColors.whiteColor,
              Color(0xFFEFFAFB),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'Home',
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

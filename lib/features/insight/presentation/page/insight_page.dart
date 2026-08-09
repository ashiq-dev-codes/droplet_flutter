import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:droplet_flutter/shared/widget/background/gradient_background.dart';
import 'package:flutter/material.dart';

class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text(
            'Insight',
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

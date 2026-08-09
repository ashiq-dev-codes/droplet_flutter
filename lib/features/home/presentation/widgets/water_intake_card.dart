import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WaterIntakeCard extends StatelessWidget {
  const WaterIntakeCard({
    super.key,
    required this.goalAmount,
    required this.currentIntake,
  });

  final String goalAmount;
  final String currentIntake;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 200,
        child: Row(
          children: [
            // Water Bottle Image
            Image.asset(
              'assets/images/water_bottle.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.water_drop,
                size: 80,
                color: AppColors.waterBlue400,
              ),
            ),
            // Intake Info
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Goal
                Text(
                  'Goal: $goalAmount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                // Current Intake
                Text(
                  currentIntake,
                  style: const TextStyle(
                    fontSize: 62,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                // Label
                Text(
                  "Today's Intake",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

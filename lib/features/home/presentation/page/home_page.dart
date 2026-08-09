import 'package:droplet_flutter/features/home/presentation/widgets/home_header.dart';
import 'package:droplet_flutter/features/home/presentation/widgets/info_cards.dart';
import 'package:droplet_flutter/features/home/presentation/widgets/today_hydration_section.dart';
import 'package:droplet_flutter/features/home/presentation/widgets/water_intake_card.dart';
import 'package:droplet_flutter/shared/widget/background/gradient_background.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 20),
            children: const [
              // App Bar
              HomeHeader(),

              SizedBox(height: 20),

              // Water Intake Card
              WaterIntakeCard(goalAmount: '3.0L', currentIntake: '1.6L'),

              SizedBox(height: 20),

              // Info Cards
              InfoCards(
                remaining: '1.4L',
                totalGoal: '3.0L',
                consistencyDays: '12',
              ),

              SizedBox(height: 24),

              // Today's Hydration Section
              TodayHydrationSection(),
            ],
          ),
        ),
      ),
    );
  }
}

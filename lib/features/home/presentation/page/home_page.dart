import 'package:droplet_flutter/features/home/presentation/widgets/home_header.dart';
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
          child: Column(
            children: const [
              // App Bar
              HomeHeader(),

              // Body
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:droplet_flutter/features/navigation/presentation/page/bottom_navbar.dart';
import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Droplet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.backgroundLight,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.waterBlue400),
      ),
      home: const BottomNavBar(),
    );
  }
}

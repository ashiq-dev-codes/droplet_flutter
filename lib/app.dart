import 'package:fitness_tracker_app/features/navigation/presentation/page/bottom_navbar.dart';
import 'package:fitness_tracker_app/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker App',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

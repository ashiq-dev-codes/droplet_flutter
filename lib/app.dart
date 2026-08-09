import 'package:droplet_flutter/features/navigation/presentation/page/bottom_navbar.dart';
import 'package:droplet_flutter/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const BottomNavBar(),
    );
  }
}

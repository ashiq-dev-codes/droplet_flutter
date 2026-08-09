import 'package:droplet_flutter/features/today/presentation/page/today_page.dart';
import 'package:droplet_flutter/features/workouts/presentation/page/workouts_page.dart';
import 'package:droplet_flutter/features/progress/presentation/page/progress_page.dart';
import 'package:droplet_flutter/features/profile/presentation/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Figma 5-tab bottom navigation bar with floating pill style.
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  static const _pages = <Widget>[
    TodayPage(),
    WorkoutsPage(),
    ProgressPage(),
    TodayPage(), // History placeholder — not in the Figma design set
    ProfilePage(),
  ];

  static const _icons = <IconData>[
    LucideIcons.house,
    LucideIcons.dumbbell,
    LucideIcons.chartNoAxesColumn,
    LucideIcons.heart,
    LucideIcons.user,
  ];

  static const _labels = <String>[
    'Today',
    'Workouts',
    'Progress',
    'History',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    return SafeArea(
      top: false,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF0E0F0C),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (i) => _buildTab(i)),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int i) {
    final active = _index == i;
    return GestureDetector(
      onTap: () => setState(() => _index = i),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: 44,
        padding: active
            ? const EdgeInsets.symmetric(horizontal: 14)
            : EdgeInsets.zero,
        decoration: active
            ? BoxDecoration(
                color: const Color(0xFFF4F2EC),
                borderRadius: BorderRadius.circular(50),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icons[i],
              size: 18,
              color: active ? const Color(0xFF0E0F0C) : const Color(0xFF8A8A82),
            ),
            if (active) ...[
              const SizedBox(width: 6),
              Text(
                _labels[i],
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1,
                  color: Color(0xFF0E0F0C),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

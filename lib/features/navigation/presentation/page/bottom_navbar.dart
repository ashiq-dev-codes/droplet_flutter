import 'package:droplet_flutter/features/profile/presentation/page/profile_page.dart';
import 'package:droplet_flutter/features/progress/presentation/page/progress_page.dart';
import 'package:droplet_flutter/features/timer/presentation/widgets/workout_timer_sheet.dart';
import 'package:droplet_flutter/features/today/presentation/page/today_page.dart';
import 'package:droplet_flutter/features/workouts/presentation/page/workouts_page.dart';
import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:droplet_flutter/shared/theme/app_font.dart';
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

  // Getter: fresh instances so hot-reload rebuilds reach the active page.
  static List<Widget> get _pages => <Widget>[
        TodayPage(),
        WorkoutsPage(),
        TodayPage(), // Center action placeholder
        ProgressPage(),
        ProfilePage(),
      ];

  static const _icons = <IconData>[
    LucideIcons.house,
    LucideIcons.dumbbell,
    LucideIcons.plus,
    LucideIcons.chartNoAxesColumn,
    LucideIcons.user,
  ];

  static const _labels = <String>[
    'Today',
    'Workouts',
    '',
    'Progress',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _index, children: _pages),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(top: false, child: _buildNavBar()),
          ),
        ],
      ),
    );
  }

  void _openTimerSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      barrierColor: AppColors.shadowDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (_) => const WorkoutTimerSheet(),
    );
  }

  Widget _buildNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(111),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (i) => _buildTab(i)),
      ),
    );
  }

  Widget _buildTab(int i) {
    final isCenter = i == 2;
    final active = _index == i;
    final showPill = active || isCenter;

    return InkWell(
      onTap: () => isCenter ? _openTimerSheet() : setState(() => _index = i),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        height: 44,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        padding: showPill
            ? const EdgeInsets.symmetric(horizontal: 16)
            : const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: showPill
              ? (isCenter ? AppColors.background : AppColors.accentLime)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icons[i],
              size: 18,
              color: isCenter || active
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
            if (_labels[i].isNotEmpty)
              AnimatedSize(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 250),
                child: SizedBox(
                  width: active ? null : 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 6),
                      Text(
                        _labels[i],
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: AppFont.inter,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

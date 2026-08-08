import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static const String routeName = 'bottom_nav_bar';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  // Placeholder pages — replace with real pages as they're built
  final _pages = const [
    _PlaceholderPage(label: 'Home'),
    _PlaceholderPage(label: 'History'),
    _PlaceholderPage(label: 'Insight'),
    _PlaceholderPage(label: 'Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    return Container(
      height: 88,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Row of nav items
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isSelected: _currentIndex == 0,
                  onTap: () => _onTap(0),
                ),
                _NavItem(
                  icon: Icons.history_rounded,
                  label: 'History',
                  isSelected: _currentIndex == 1,
                  onTap: () => _onTap(1),
                ),
                const SizedBox(width: 60), // spacer for center FAB
                _NavItem(
                  icon: Icons.bar_chart_rounded,
                  label: 'Insight',
                  isSelected: _currentIndex == 2,
                  onTap: () => _onTap(2),
                ),
                _NavItem(
                  icon: Icons.settings_rounded,
                  label: 'Setting',
                  isSelected: _currentIndex == 3,
                  onTap: () => _onTap(3),
                ),
              ],
            ),
          ),
          // Center raised + button
          Positioned(child: _CenterButton(onTap: () {})),
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }
}

/// Center raised circular + button
class _CenterButton extends StatelessWidget {
  const _CenterButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        child: const Icon(Icons.add_rounded, color: Colors.black, size: 25),
      ),
    );
  }
}

/// Individual nav bar item
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.textPrimary : AppColors.textTertiary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Temporary placeholder page
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, color: AppColors.textSecondary),
      ),
    );
  }
}

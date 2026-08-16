import 'package:fitness_tracker_app/shared/path/app_images.dart';
import 'package:fitness_tracker_app/shared/theme/app_colors.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: Column(
          children: [
            // Header
            _ProfileHeader(),
            SizedBox(height: 32),

            // Stats
            _BodyStats(),
            SizedBox(height: 32),

            // Menu
            _MenuSection(
              title: 'ACCOUNT',
              items: [
                _MenuItem(LucideIcons.user, 'Personal Information'),
                _MenuItem(LucideIcons.target, 'My Goals'),
                _MenuItem(LucideIcons.creditCard, 'Subscription'),
              ],
            ),
            SizedBox(height: 24),

            // Settings
            _MenuSection(
              title: 'SETTINGS',
              items: [
                _MenuItemWithTrailing(
                  LucideIcons.bell,
                  'Notifications',
                  trailing: _OnBadge(),
                ),
                _MenuItemWithTrailing(
                  LucideIcons.bluetooth,
                  'Connected Devices',
                  trailing: Icon(
                    LucideIcons.compass,
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                _MenuItem(LucideIcons.shield, 'Privacy & Security'),
              ],
            ),
            SizedBox(height: 24),

            // Support
            _MenuSection(
              title: 'SUPPORT',
              items: [
                _MenuItem(LucideIcons.helpCircle, 'FAQ & Help'),
                _MenuItem(
                  LucideIcons.logOut,
                  'Log out',
                  showTrailing: false,
                  color: AppColors.accentOrange,
                ),
              ],
            ),
            SizedBox(height: 24),

            // Version
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'PULSE V4.7.2',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.0,
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1111),
                border: Border.all(width: 4, color: AppColors.accentLime),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1111),
                child: Image.asset(
                  AppImages.avatar,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    LucideIcons.user,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  LucideIcons.camera,
                  size: 14,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Mara Jensen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: AppFont.spaceGrotesk,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'mara.jensen@pulse.app',
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(111),
            color: AppColors.accentLime.withValues(alpha: 0.20),
          ),
          child: const Text(
            'PREMIUM MEMBER',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 0.5,
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _BodyStats extends StatelessWidget {
  const _BodyStats();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Stat('AGE', '28', null),
          _Divider(),
          _Stat('WEIGHT', '64', 'kg'),
          _Divider(),
          _Stat('HEIGHT', '172', 'cm'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;

  const _Stat(this.label, this.value, this.unit);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            letterSpacing: 1.8,
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 5.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: AppFont.spaceGrotesk,
              ),
            ),
            if (unit != null)
              Text(
                unit!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  fontFamily: AppFont.spaceGrotesk,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 47,
      color: AppColors.divider.withValues(alpha: 0.50),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            letterSpacing: 2.0,
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: items.length,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => items[index],
            separatorBuilder: (context, index) => Container(
              height: 1,
              width: double.maxFinite,
              color: AppColors.divider.withValues(alpha: 0.50),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool showTrailing;
  final Color? color;

  const _MenuItem(
    this.icon,
    this.label, {
    this.showTrailing = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color ?? AppColors.textSecondary),
          const SizedBox(width: 13.67),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w600,
                color: color ?? AppColors.textPrimary,
              ),
            ),
          ),
          if (showTrailing)
            Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: AppColors.textSecondary,
            ),
        ],
      ),
    );
  }
}

class _MenuItemWithTrailing extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;

  const _MenuItemWithTrailing(this.icon, this.label, {required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 13.67),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _OnBadge extends StatelessWidget {
  const _OnBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 5.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(111),
        color: AppColors.accentLime.withValues(alpha: 0.20),
      ),
      child: const Text(
        'ON',
        style: TextStyle(
          fontSize: 10,
          fontFamily: AppFont.inter,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

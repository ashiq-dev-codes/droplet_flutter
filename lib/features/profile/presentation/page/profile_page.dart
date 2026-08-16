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
            _ProfileHeader(),
            SizedBox(height: 24),
            _BodyStats(),
            SizedBox(height: 24),
            _MenuSection(
              title: 'ACCOUNT',
              items: [
                _MenuItem(LucideIcons.user, 'Personal Information'),
                _MenuItem(LucideIcons.target, 'My Goals'),
                _MenuItem(LucideIcons.creditCard, 'Subscription'),
              ],
            ),
            SizedBox(height: 20),
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
                  trailing: _DeviceIcons(),
                ),
                _MenuItem(LucideIcons.shield, 'Privacy & Security'),
              ],
            ),
            SizedBox(height: 20),
            _MenuSection(
              title: 'SUPPORT',
              items: [
                _MenuItem(LucideIcons.helpCircle, 'FAQ & Help'),
                _MenuItem(LucideIcons.logOut, 'Log out', isDestructive: true),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'PULSE V4.7.2',
              style: TextStyle(
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w400,
                fontSize: 10,
                letterSpacing: 1.0,
                color: AppColors.textSecondary,
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
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.surface,
              child: ClipOval(
                child: Image.asset(
                  AppImages.avatar,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    LucideIcons.user,
                    size: 40,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 3),
                ),
                child: const Icon(
                  LucideIcons.camera,
                  size: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Mara Jensen',
          style: TextStyle(
            fontFamily: AppFont.spaceGrotesk,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            height: 1.33,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'mara.jensen@pulse.app',
          style: TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'PREMIUM MEMBER',
            style: TextStyle(
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.w700,
              fontSize: 10,
              letterSpacing: 0.5,
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
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
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
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w400,
            fontSize: 10,
            letterSpacing: 1.8,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: AppFont.spaceGrotesk,
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: AppColors.textPrimary,
              ),
            ),
            if (unit != null)
              Text(
                unit!,
                style: const TextStyle(
                  fontFamily: AppFont.spaceGrotesk,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.textSecondary,
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
    return Container(width: 1, height: 32, color: AppColors.divider);
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w700,
                fontSize: 10,
                letterSpacing: 2.0,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;

  const _MenuItem(this.icon, this.label, {this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? AppColors.accentOrange
        : AppColors.textPrimary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: color,
              ),
            ),
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w600,
                fontSize: 14,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accentLime,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'ON',
        style: TextStyle(
          fontFamily: AppFont.inter,
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _DeviceIcons extends StatelessWidget {
  const _DeviceIcons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.watch, size: 16, color: AppColors.textPrimary),
        const SizedBox(width: 4),
        Icon(LucideIcons.watch, size: 16, color: AppColors.textPrimary),
      ],
    );
  }
}

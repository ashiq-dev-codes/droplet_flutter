import 'package:fitness_tracker_app/shared/theme/app_colors.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Progress',
              style: TextStyle(
                fontFamily: AppFont.spaceGrotesk,
                fontWeight: FontWeight.w700,
                fontSize: 30,
                height: 1.2,
                letterSpacing: -0.75,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16),
            // Filter tabs
            _FilterTabs(),
            SizedBox(height: 20),
            // Stats row
            _StatsRow(),
            SizedBox(height: 24),
            // Chart
            _ActivityVolumeChart(),
            SizedBox(height: 24),
            // Personal records
            _PersonalRecords(),
          ],
        ),
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  const _FilterTabs();

  @override
  Widget build(BuildContext context) {
    const tabs = ['Week', 'Month', 'Year', 'All time'];
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = i == 0;
          return Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? AppColors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: AppColors.textPrimary.withValues(alpha: 0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                  fontSize: 12,
                  color: active
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _stat('WORKOUTS', '12', null, AppColors.accentLime, '+2 from avg'),
          _divider(),
          _stat('TIME', '8.4', 'h', null, 'Weekly avg'),
          _divider(),
          _stat('CALS', '4.2k', null, AppColors.accentOrange, '+12% vs last'),
        ],
      ),
    );
  }

  Widget _stat(
    String label,
    String value,
    String? unit,
    Color? badgeColor,
    String badge,
  ) {
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
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: AppFont.spaceGrotesk,
                fontWeight: FontWeight.w700,
                fontSize: 26,
                height: 1,
                letterSpacing: -1.3,
                color: AppColors.textPrimary,
              ),
            ),
            if (unit != null)
              Text(
                unit,
                style: const TextStyle(
                  fontFamily: AppFont.spaceGrotesk,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          badge,
          style: TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w700,
            fontSize: 9,
            color: badgeColor ?? AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 40, color: AppColors.divider);
  }
}

class _ActivityVolumeChart extends StatelessWidget {
  const _ActivityVolumeChart();

  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _heights = [64.0, 112.0, 48.0, 133.0, 133.0, 80.0, 32.0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Activity Volume',
                    style: TextStyle(
                      fontFamily: AppFont.spaceGrotesk,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      height: 1.55,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Daily burn comparison',
                    style: TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Icon(LucideIcons.info, size: 16, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final isActive = i == 4 || i == 5 || i == 6;
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 33,
                        height: _heights[i],
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.accentLime
                              : AppColors.divider,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _days[i],
                        style: TextStyle(
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                          color: isActive
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalRecords extends StatelessWidget {
  const _PersonalRecords();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Records',
          style: TextStyle(
            fontFamily: AppFont.spaceGrotesk,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            height: 1.55,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        _record(
          icon: LucideIcons.mapPin,
          title: 'Longest Run',
          date: 'Oct 24, 2023',
          value: '12.4 km',
          badge: 'New Record!',
        ),
        const SizedBox(height: 8),
        _record(
          icon: LucideIcons.flame,
          title: 'Max Kcal Burned',
          date: 'Jan 12, 2024',
          value: '1,240 kcal',
          badge: null,
        ),
      ],
    );
  }

  Widget _record({
    required IconData icon,
    required String title,
    required String date,
    required String value,
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: AppFont.spaceGrotesk,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: AppFont.spaceGrotesk,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              if (badge != null)
                Text(
                  badge,
                  style: const TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: AppColors.accentLime,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

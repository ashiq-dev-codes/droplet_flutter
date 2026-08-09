import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:droplet_flutter/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TodayHeader(),
            SizedBox(height: 16),
            _KcalCard(),
            SizedBox(height: 16),
            _StreakCard(),
            SizedBox(height: 24),
            _ActivitySection(),
            SizedBox(height: 24),
            _WorkoutsSection(),
            SizedBox(height: 24),
            _WeekTotalsCard(),
          ],
        ),
      ),
    );
  }
}

// ── Header ──────────────────────────────────────────────────────
class _TodayHeader extends StatelessWidget {
  const _TodayHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.surface,
          child: ClipOval(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Icon(
                LucideIcons.user,
                size: 20,
                color: AppColors.inkSoft,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Greeting
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TUESDAY · WEEK 18',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 11,
                letterSpacing: 2.2,
                height: 1,
                color: AppColors.inkSoft,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Morning, Mara.',
              style: TextStyle(
                fontFamily: AppTheme.displayFont,
                fontWeight: FontWeight.w600,
                fontSize: 17,
                height: 1.29,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
        const Spacer(),
        // Icons
        _iconButton(LucideIcons.bell),
        const SizedBox(width: 8),
        _iconButton(LucideIcons.search),
      ],
    );
  }

  static Widget _iconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 18, color: AppColors.ink),
    );
  }
}

// ── kcal card (dark) ────────────────────────────────────────────
class _KcalCard extends StatelessWidget {
  const _KcalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          // Left column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TODAY · KCAL BURNED',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    letterSpacing: 2.2,
                    height: 1.5,
                    color: AppColors.inkSoft,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '1,842',
                  style: TextStyle(
                    fontFamily: AppTheme.displayFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 76,
                    height: 1.0,
                    letterSpacing: -3.8,
                    color: AppColors.accentOrange,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Goal pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.ink,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF2A2C28), width: 1),
                      ),
                      child: const Text(
                        'GOAL 2,400',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          height: 1.5,
                          color: AppColors.inkSoft,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      '76% · 558 to go',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5,
                        color: AppColors.inkSoft,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Donut chart
          SizedBox(
            width: 112,
            height: 112,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 0.78,
                    strokeWidth: 12,
                    backgroundColor: const Color(0xFF2A2C28),
                    valueColor: const AlwaysStoppedAnimation(
                        AppColors.accentOrange),
                  ),
                ),
                SizedBox(
                  width: 76,
                  height: 76,
                  child: CircularProgressIndicator(
                    value: 0.78,
                    strokeWidth: 8,
                    backgroundColor: const Color(0xFF2A2C28),
                    valueColor: const AlwaysStoppedAnimation(
                        AppColors.accentLime),
                  ),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MOVE',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 9,
                        letterSpacing: 1.6,
                        color: AppColors.inkSoft,
                      ),
                    ),
                    Text(
                      '78%',
                      style: TextStyle(
                        fontFamily: AppTheme.displayFont,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        height: 1,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Streak card (dark) ──────────────────────────────────────────
class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              const Icon(LucideIcons.flame, size: 16, color: AppColors.accentOrange),
              const SizedBox(width: 6),
              const Text(
                'STREAK',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  letterSpacing: 2.2,
                  height: 1.5,
                  color: AppColors.accentLime,
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    '17',
                    style: TextStyle(
                      fontFamily: AppTheme.displayFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: AppColors.accentLime,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'days',
                    style: TextStyle(
                      fontFamily: AppTheme.displayFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.inkSoft,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Bar chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _bar('M', 28, true),
              _bar('T', 28, true),
              _bar('W', 14, false),
              _bar('T', 28, true),
              _bar('F', 28, true),
              _bar('S', 28, true),
              _bar('S', 36, true),
              _bar('M', 28, true),
              _bar('T', 28, true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bar(String label, double height, bool filled) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: height,
            width: 6,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: filled ? AppColors.accentLime : const Color(0xFF2A2C28),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 9,
              letterSpacing: 1.35,
              color: filled ? AppColors.inkSoft : const Color(0xFF2A2C28),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Today's activity ────────────────────────────────────────────
class _ActivitySection extends StatelessWidget {
  const _ActivitySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's activity",
              style: TextStyle(
                fontFamily: AppTheme.displayFont,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppColors.ink,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Details',
                  style: TextStyle(
                    fontFamily: AppTheme.bodyFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(LucideIcons.chevronRight, size: 14, color: AppColors.ink),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 2x2 grid
        Row(
          children: [
            Expanded(child: _statCard(LucideIcons.footprints, 'STEPS', '8,240', null, '/ 10,000')),
            const SizedBox(width: 12),
            Expanded(child: _statCard(LucideIcons.timer, 'ACTIVE MIN', '62', 'min', '+18% vs avg')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _statCard(LucideIcons.heartPulse, 'RESTING HR', '54', 'bpm', null)),
            const SizedBox(width: 12),
            Expanded(child: _statCard(LucideIcons.apple, 'INTAKE', '1,420', 'kcal', null)),
          ],
        ),
      ],
    );
  }

  Widget _statCard(IconData icon, String label, String value, String? unit, String? badge) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + label
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.inkSoft),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  letterSpacing: 1.8,
                  color: AppColors.inkSoft,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Value
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: AppTheme.displayFont,
                  fontWeight: FontWeight.w700,
                  fontSize: 34,
                  height: 1,
                  letterSpacing: -1.7,
                  color: AppColors.ink,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 2),
                Text(
                  unit,
                  style: const TextStyle(
                    fontFamily: AppTheme.displayFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.inkSoft,
                  ),
                ),
              ],
            ],
          ),
          if (badge != null) ...[
            const SizedBox(height: 4),
            Text(
              badge,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 11,
                height: 1.5,
                color: AppColors.inkSoft,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Recent workouts ─────────────────────────────────────────────
class _WorkoutsSection extends StatelessWidget {
  const _WorkoutsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent workouts',
              style: TextStyle(
                fontFamily: AppTheme.displayFont,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppColors.ink,
              ),
            ),
            Row(
              children: [
                _filterChip('All', true),
                const SizedBox(width: 6),
                _filterChip('Run', false),
                const SizedBox(width: 6),
                _filterChip('Lift', false),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        _workoutTile(
          icon: LucideIcons.activity,
          tag: 'TEMPO RUN',
          tagBadge: 'PR',
          title: 'Riverside 8K',
          duration: '42:18',
          calories: '612',
          pace: '5:16 /km',
        ),
        const SizedBox(height: 10),
        _workoutTile(
          icon: LucideIcons.dumbbell,
          tag: 'STRENGTH · PUSH',
          title: 'Upper body · heavy',
          duration: '58:04',
          calories: '486',
          pace: '9 sets',
        ),
        const SizedBox(height: 10),
        _workoutTile(
          icon: LucideIcons.armchair,
          tag: 'MOBILITY',
          title: 'Morning flow',
          duration: '22:40',
          calories: '118',
          pace: 'Low',
        ),
      ],
    );
  }

  Widget _filterChip(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: active ? AppColors.ink : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: active ? AppColors.white : AppColors.ink,
        ),
      ),
    );
  }

  Widget _workoutTile({
    required IconData icon,
    required String tag,
    String? tagBadge,
    required String title,
    required String duration,
    required String calories,
    required String pace,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 28, color: AppColors.ink),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      tag,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        letterSpacing: 1.8,
                        color: AppColors.inkSoft,
                      ),
                    ),
                    if (tagBadge != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        tagBadge,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          letterSpacing: 1.8,
                          color: AppColors.accentOrange,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: AppTheme.displayFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(duration,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.ink)),
                    const SizedBox(width: 4),
                    const Text('min',
                        style: TextStyle(
                            fontFamily: AppTheme.displayFont,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.inkSoft)),
                    const SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: 12,
                      color: AppColors.surfaceBorder,
                    ),
                    const SizedBox(width: 10),
                    Text(calories,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.accentOrange)),
                    const SizedBox(width: 4),
                    const Text('kcal',
                        style: TextStyle(
                            fontFamily: AppTheme.displayFont,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.inkSoft)),
                    const SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: 12,
                      color: AppColors.surfaceBorder,
                    ),
                    const SizedBox(width: 10),
                    Text(pace,
                        style: const TextStyle(
                            fontFamily: AppTheme.displayFont,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.ink)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, size: 14, color: AppColors.ink),
        ],
      ),
    );
  }
}

// ── Week totals ─────────────────────────────────────────────────
class _WeekTotalsCard extends StatelessWidget {
  const _WeekTotalsCard();

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
              const Text(
                'Week 18 · totals',
                style: TextStyle(
                  fontFamily: AppTheme.displayFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.ink,
                ),
              ),
              const Text(
                'Mon — Sun',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  height: 1.5,
                  color: AppColors.inkSoft,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statItem('WORKOUTS', '06', null),
              _statItem('TIME', '5:12', 'h'),
              _statItem('DISTANCE', '34.2', 'km'),
              _statItem('BURN', '8,914', null),
            ],
          ),
          const Divider(height: 32, color: AppColors.surfaceBorder),
          // Weekly bar chart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _weekBar('M', 38, true),
              _weekBar('T', 42, false),
              _weekBar('W', 11, false),
              _weekBar('T', 42, false),
              _weekBar('F', 30, false),
              _weekBar('S', 42, false),
              _weekBar('S', 42, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, String? unit) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 10,
            letterSpacing: 0.5,
            color: AppColors.inkSoft,
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
                fontFamily: AppTheme.displayFont,
                fontWeight: FontWeight.w700,
                fontSize: 26,
                height: 1,
                letterSpacing: -1.3,
                color: AppColors.ink,
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 1),
              Text(
                unit,
                style: const TextStyle(
                  fontFamily: AppTheme.displayFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.inkSoft,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _weekBar(String label, double height, bool highlight) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: height,
          decoration: BoxDecoration(
            color: highlight ? AppColors.accentLime : AppColors.surfaceBorder,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 9,
            letterSpacing: 1.35,
            color: highlight ? AppColors.ink : AppColors.inkSoft,
          ),
        ),
      ],
    );
  }
}

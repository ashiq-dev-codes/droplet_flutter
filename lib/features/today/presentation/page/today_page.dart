import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:droplet_flutter/shared/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

String _commaFormat(int n) {
  final s = n.toString();
  final out = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) out.write(',');
    out.write(s[i]);
  }
  return out.toString();
}

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          _TodayHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),

                  // Kcal
                  _KcalCard(),
                  SizedBox(height: 32),

                  // Streak
                  _StreakCard(),
                  SizedBox(height: 24),

                  // Activity
                  _ActivitySection(),
                  SizedBox(height: 24),

                  // Workouts
                  _WorkoutsSection(),
                  SizedBox(height: 24),

                  // Week totals
                  _WeekTotalsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Header ──────────────────────────────────────────────────────
class _TodayHeader extends StatelessWidget {
  const _TodayHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
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
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Greeting
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TUESDAY · WEEK 18',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2.2,
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                'Morning, Mara.',
                style: TextStyle(
                  fontSize: 17,
                  height: 1.29,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontFamily: AppFont.spaceGrotesk,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Icons
          _iconButton(icon: LucideIcons.search),
          const SizedBox(width: 8),
          _iconButton(icon: LucideIcons.bell, showIndicator: true),
        ],
      ),
    );
  }

  static Widget _iconButton({
    required IconData icon,
    bool showIndicator = false,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.backgroundDark,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Icon(icon, size: 18, color: AppColors.textPrimary),
          if (showIndicator)
            Positioned(
              top: 9,
              right: 11,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentOrange,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── kcal card (dark) ────────────────────────────────────────────
class _KcalCard extends StatefulWidget {
  const _KcalCard();

  @override
  State<_KcalCard> createState() => _KcalCardState();
}

class _KcalCardState extends State<_KcalCard>
    with SingleTickerProviderStateMixin {
  // One controller drives the number, rings and % so they stay in sync.
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..forward();

  @override
  void didUpdateWidget(_KcalCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0); // replay on hot reload / tab return
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatInt(int n) {
    final s = n.toString();
    final out = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) out.write(',');
      out.write(s[i]);
    }
    return out.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left column
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TODAY · KCAL BURNED',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2.2,
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = Curves.easeOutCubic.transform(_controller.value);

                  return Text(
                    _formatInt((1842 * t).round()),
                    style: TextStyle(
                      fontSize: 84,
                      letterSpacing: -3.8,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentOrange,
                      fontFamily: AppFont.spaceGrotesk,
                    ),
                  );
                },
              ),
              const SizedBox(height: 11.59),
              Row(
                children: [
                  // Goal pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 9,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary, width: 1),
                    ),
                    child: const Text(
                      'GOAL 2,400',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w500,
                        color: AppColors.background,
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Text(
                    '76% · 558 to go',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Donut chart (rings + % driven by one animated progress value)
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final progress =
                0.78 * Curves.easeOutCubic.transform(_controller.value);

            return SizedBox(
              width: 131,
              height: 131,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 12,
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.surface,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.accentOrange,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(17),
                    child: SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 8,
                        strokeCap: StrokeCap.round,
                        backgroundColor: AppColors.surface,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.accentLime,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'MOVE',
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontFamily: AppFont.spaceGrotesk,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// ── Streak card (dark) ──────────────────────────────────────────
class _StreakCard extends StatefulWidget {
  const _StreakCard();

  @override
  State<_StreakCard> createState() => _StreakCardState();
}

class _StreakCardState extends State<_StreakCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..forward();

  @override
  void didUpdateWidget(_StreakCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0); // replay on hot reload / tab return
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.flame,
                  size: 16,
                  color: AppColors.accentLime,
                ),
                const SizedBox(width: 8),
                const Text(
                  'STREAK',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2.2,
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w400,
                    color: AppColors.borderLight,
                  ),
                ),
                const Spacer(),
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    const Text(
                      '17',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentLime,
                        fontFamily: AppFont.spaceGrotesk,
                      ),
                    ),
                    const Text(
                      'days',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.borderLight,
                        fontFamily: AppFont.spaceGrotesk,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.5),
          // Bar chart
          SizedBox(
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ── Week 1 (past) ────────────
                  _bar(
                    label: 'M',
                    height: 28,
                    barColor: AppColors.background,
                    labelColor: AppColors.background.withValues(alpha: 0.5),
                  ),
                  _bar(
                    label: 'T',
                    height: 28,
                    barColor: AppColors.background,
                    labelColor: AppColors.background.withValues(alpha: 0.5),
                  ),
                  _bar(
                    label: 'W',
                    height: 14,
                    barColor: AppColors.background,
                    labelColor: AppColors.background.withValues(alpha: 0.5),
                  ),
                  _bar(
                    label: 'T',
                    height: 28,
                    barColor: AppColors.background,
                    labelColor: AppColors.background.withValues(alpha: 0.5),
                  ),
                  _bar(
                    label: 'F',
                    height: 28,
                    barColor: AppColors.background,
                    labelColor: AppColors.background.withValues(alpha: 0.5),
                  ),
                  _bar(
                    label: 'S',
                    height: 28,
                    barColor: AppColors.background,
                    labelColor: AppColors.background.withValues(alpha: 0.5),
                  ),
                  _bar(
                    label: 'S',
                    height: 36,
                    barColor: AppColors.accentLime,
                    labelColor: AppColors.accentLime,
                  ),
                  _weekDivider(),
                  // ── Week 2 (current) ─────────
                  _bar(
                    label: 'M',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'T',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'W',
                    height: 14,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'T',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'F',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'S',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'S',
                    height: 36,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _weekDivider(),
                  // ── Week 3 ────────────────────
                  _bar(
                    label: 'M',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'T',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'W',
                    height: 14,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'T',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'F',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'S',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'S',
                    height: 36,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _weekDivider(),
                  // ── Week 4 ────────────────────
                  _bar(
                    label: 'M',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'T',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'W',
                    height: 14,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'T',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'F',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'S',
                    height: 28,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                  _bar(
                    label: 'S',
                    height: 36,
                    barColor: AppColors.background.withValues(alpha: 0.2),
                    labelColor: AppColors.background.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar({
    required String label,
    required double height,
    required Color barColor,
    required Color labelColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = Curves.easeOutCubic.transform(_controller.value);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: height > 0 ? height * t : 4,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(111),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  color: labelColor,
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _weekDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Container(
        width: 1,
        height: 28,
        color: AppColors.borderLight.withValues(alpha: 0.15),
      ),
    );
  }
}

// ── Today's activity ────────────────────────────────────────────
class _ActivitySection extends StatefulWidget {
  const _ActivitySection();

  @override
  State<_ActivitySection> createState() => _ActivitySectionState();
}

class _ActivitySectionState extends State<_ActivitySection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..forward();

  @override
  void didUpdateWidget(_ActivitySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0); // replay on hot reload / tab return
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's activity",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontFamily: AppFont.spaceGrotesk,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  LucideIcons.arrowUpRight,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 2x2 grid
        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: LucideIcons.footprints,
                label: 'STEPS',
                targetValue: 8240,
                badge: '/ 10,000',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                icon: LucideIcons.activity,
                label: 'ACTIVE MIN',
                targetValue: 62,
                unit: 'min',
                badge: '+18% vs avg',
                color: AppColors.accentLime,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: LucideIcons.heartPulse,
                label: 'RESTING HR',
                targetValue: 54,
                unit: 'bpm',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                icon: LucideIcons.forkKnife,
                label: 'INTAKE',
                targetValue: 1420,
                unit: 'kcal',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statCard({
    String? unit,
    String? badge,
    required String label,
    required num targetValue,
    required IconData icon,
    Color color = AppColors.backgroundDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
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
            ],
          ),
          const SizedBox(height: 50),

          // Value
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = Curves.easeOutCubic.transform(_controller.value);
                  return Text(
                    _commaFormat((targetValue * t).round()),
                    style: const TextStyle(
                      fontSize: 34,
                      letterSpacing: -1.7,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: AppFont.spaceGrotesk,
                    ),
                  );
                },
              ),
              if (unit != null) ...[
                const SizedBox(width: 2),
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    fontFamily: AppFont.spaceGrotesk,
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
                fontSize: 11,
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
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
                fontFamily: AppFont.spaceGrotesk,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppColors.textPrimary,
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
        color: active ? AppColors.textPrimary : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: AppFont.inter,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: active ? AppColors.white : AppColors.textPrimary,
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
            child: Icon(icon, size: 28, color: AppColors.textPrimary),
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
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        letterSpacing: 1.8,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (tagBadge != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        tagBadge,
                        style: const TextStyle(
                          fontFamily: AppFont.inter,
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
                    fontFamily: AppFont.spaceGrotesk,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      duration,
                      style: const TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'min',
                      style: TextStyle(
                        fontFamily: AppFont.spaceGrotesk,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(width: 1, height: 12, color: AppColors.divider),
                    const SizedBox(width: 10),
                    Text(
                      calories,
                      style: const TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.accentOrange,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'kcal',
                      style: TextStyle(
                        fontFamily: AppFont.spaceGrotesk,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(width: 1, height: 12, color: AppColors.divider),
                    const SizedBox(width: 10),
                    Text(
                      pace,
                      style: const TextStyle(
                        fontFamily: AppFont.spaceGrotesk,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            LucideIcons.chevronRight,
            size: 14,
            color: AppColors.textPrimary,
          ),
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
                  fontFamily: AppFont.spaceGrotesk,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'Mon — Sun',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  height: 1.5,
                  color: AppColors.textSecondary,
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
          const Divider(height: 32, color: AppColors.divider),
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
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w400,
            fontSize: 10,
            letterSpacing: 0.5,
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
                fontSize: 26,
                height: 1,
                letterSpacing: -1.3,
                color: AppColors.textPrimary,
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 1),
              Text(
                unit,
                style: const TextStyle(
                  fontFamily: AppFont.spaceGrotesk,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.textSecondary,
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
            color: highlight ? AppColors.accentLime : AppColors.divider,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w700,
            fontSize: 9,
            letterSpacing: 1.35,
            color: highlight ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

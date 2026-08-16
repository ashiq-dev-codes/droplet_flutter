import 'package:fitness_tracker_app/shared/theme/app_colors.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:fitness_tracker_app/shared/widgets/page_visibility.dart';
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

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            floating: false,
            titleSpacing: 24,
            toolbarHeight: 53,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.background,
            title: Row(
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: AppFont.spaceGrotesk,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 7)),

          // Filter tabs
          SliverToBoxAdapter(child: _FilterTabs()),
          SliverToBoxAdapter(child: SizedBox(height: 16.5)),
        ],
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 16.5,
            left: 24,
            right: 24,
            bottom: 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats row
              _StatsRow(),
              SizedBox(height: 32),

              // Chart
              _ActivityVolumeChart(),
              SizedBox(height: 32),

              // Personal records
              _PersonalRecords(),
              SizedBox(height: 15),

              // Achievements
              _AchievementsRow(),
            ],
          ),
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
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = i == 0;

          return Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: active ? AppColors.white : Colors.transparent,
                boxShadow: active
                    ? [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: -1,
                          offset: const Offset(0, 1),
                          color: AppColors.black.withValues(alpha: 0.10),
                        ),
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: const Offset(0, 1),
                          color: AppColors.black.withValues(alpha: 0.10),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFont.inter,
                  fontWeight: active ? FontWeight.bold : FontWeight.w700,
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

class _StatsRow extends StatefulWidget {
  const _StatsRow();

  @override
  State<_StatsRow> createState() => _StatsRowState();
}

class _StatsRowState extends State<_StatsRow>
    with SingleTickerProviderStateMixin, PageVisibilityMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..forward();

  @override
  void onBecomeVisible() => _controller.forward(from: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _stat(
          'WORKOUTS',
          12,
          (v) => v.round().toString(),
          null,
          null,
          AppColors.accentLime,
          '+2 from avg',
        ),
        SizedBox(width: 12),
        _stat(
          'TIME',
          8.4,
          (v) => v.toStringAsFixed(1),
          null,
          'h',
          null,
          'Weekly avg',
        ),
        SizedBox(width: 12),
        _stat(
          'CALS',
          4.2,
          (v) => '${v.toStringAsFixed(1)}k',
          AppColors.accentOrange,
          null,
          AppColors.accentOrange,
          '+12% vs last',
        ),
      ],
    );
  }

  Widget _stat(
    String label,
    num targetValue,
    String Function(double) formatValue,
    Color? textColor,
    String? unit,
    Color? badgeColor,
    String badge,
  ) {
    return Expanded(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
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
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final t = Curves.easeOutCubic.transform(_controller.value);
                    return Text(
                      formatValue(targetValue * t),
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: -1.3,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFont.spaceGrotesk,
                        color: textColor ?? AppColors.textPrimary,
                      ),
                    );
                  },
                ),
                if (unit != null)
                  Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      fontFamily: AppFont.spaceGrotesk,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              badge,
              style: TextStyle(
                fontSize: 9,
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.bold,
                color: badgeColor ?? AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityVolumeChart extends StatefulWidget {
  const _ActivityVolumeChart();

  @override
  State<_ActivityVolumeChart> createState() => _ActivityVolumeChartState();
}

class _ActivityVolumeChartState extends State<_ActivityVolumeChart>
    with SingleTickerProviderStateMixin, PageVisibilityMixin {
  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _heights = [64.0, 112.0, 48.0, 133.0, 133.0, 80.0, 32.0];

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..forward();

  @override
  void onBecomeVisible() => _controller.forward(from: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: AppFont.spaceGrotesk,
                    ),
                  ),
                  const Text(
                    'Daily burn comparison',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Icon(LucideIcons.info, size: 16, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final isActive = i == 4;
                final isFull = i == 1 || i == 3;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          final t = Curves.easeOutCubic.transform(
                            _controller.value,
                          );
                          return Container(
                            width: 33,
                            height: _heights[i] * t,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.accentLime
                                  : isFull
                                  ? AppColors.primary
                                  : AppColors.backgroundDark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _days[i],
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.bold,
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

class _PersonalRecords extends StatefulWidget {
  const _PersonalRecords();

  @override
  State<_PersonalRecords> createState() => _PersonalRecordsState();
}

class _PersonalRecordsState extends State<_PersonalRecords>
    with SingleTickerProviderStateMixin, PageVisibilityMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..forward();

  @override
  void onBecomeVisible() => _controller.forward(from: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Records',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: AppFont.spaceGrotesk,
          ),
        ),
        const SizedBox(height: 16),
        _record(
          icon: LucideIcons.trophy,
          iconColor: AppColors.accentLime,
          title: 'Longest Run',
          date: 'Oct 24, 2023',
          targetValue: 12.4,
          formatValue: (v) => '${v.toStringAsFixed(1)} km',
          badge: 'New Record!',
        ),
        const SizedBox(height: 12),
        _record(
          icon: LucideIcons.flame,
          iconColor: AppColors.accentOrange,
          title: 'Max Kcal Burned',
          date: 'Jan 12, 2024',
          targetValue: 1240,
          formatValue: (v) => '${_commaFormat(v.round())} kcal',
          badge: null,
        ),
      ],
    );
  }

  Widget _record({
    required IconData icon,
    required String title,
    required String date,
    required num targetValue,
    required String Function(double) formatValue,
    String? badge,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor ?? AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: AppFont.spaceGrotesk,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = Curves.easeOutCubic.transform(_controller.value);
                  return Text(
                    formatValue(targetValue * t),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: AppFont.spaceGrotesk,
                    ),
                  );
                },
              ),
              if (badge != null) ...[
                const SizedBox(height: 1),
                Text(
                  badge,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentLime,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _AchievementsRow extends StatelessWidget {
  const _AchievementsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Achievements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: AppFont.spaceGrotesk,
              ),
            ),
            Text(
              'View all',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
                fontFamily: AppFont.spaceGrotesk,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _achievementsCard(
              child: Icon(LucideIcons.circle, color: AppColors.accentLime),
            ),
            _achievementsCard(
              child: Icon(LucideIcons.flame, color: AppColors.accentOrange),
            ),
            _achievementsCard(
              child: Icon(
                LucideIcons.calendarDays,
                color: AppColors.accentBlue,
              ),
            ),
            _achievementsCard(
              child: Icon(LucideIcons.star, color: AppColors.accentGold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _achievementsCard({required Widget child}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
      child: child,
    );
  }
}

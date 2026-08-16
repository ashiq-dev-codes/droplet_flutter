import 'package:fitness_tracker_app/shared/theme/app_colors.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:fitness_tracker_app/shared/widgets/page_visibility.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
              SizedBox(height: 24),
              // Chart
              _ActivityVolumeChart(),
              SizedBox(height: 24),
              // Personal records
              _PersonalRecords(),
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

import 'package:fitness_tracker_app/features/profile/presentation/page/profile_page.dart';
import 'package:fitness_tracker_app/features/progress/presentation/page/progress_page.dart';
import 'package:fitness_tracker_app/features/timer/presentation/widgets/workout_timer_sheet.dart';
import 'package:fitness_tracker_app/features/today/presentation/page/today_page.dart';
import 'package:fitness_tracker_app/features/workouts/presentation/page/workouts_page.dart';
import 'package:fitness_tracker_app/shared/theme/app_colors.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:fitness_tracker_app/shared/widgets/page_visibility.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Figma 5-tab bottom navigation bar with floating pill style.
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const _navMarginX = 20.0;
  static const _navPaddingX = 6.0;
  static const _navPadding = EdgeInsets.symmetric(
    vertical: 11,
    horizontal: _navPaddingX,
  );
  // The GestureDetector wraps the whole margin+padding box, so its
  // localPosition is in that outer space; the drag pill instead lives in
  // the inner content Stack (inside the padding). This is the offset
  // between the two coordinate spaces.
  static const _contentOffsetX = _navMarginX + _navPaddingX;
  static const _dragPillSize = 50.0;

  int _index = 0;
  int? _dragIndex;
  // Raw pointer x (in bar-content space) while pressed/dragging. The pill
  // tracks this value directly with zero animation lag, so it glides
  // continuously under the finger — like iOS's tab bar — instead of
  // hopping discretely from slot to slot.
  double? _dragLocalX;
  final GlobalKey _navKey = GlobalKey();
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      TodayPage(),
      WorkoutsPage(),
      TodayPage(), // Center action placeholder
      ProgressPage(),
      ProfilePage(),
    ];
  }

  // Content width (inside margin + padding) — matches the LayoutBuilder
  // constraints that position the drag pill and tabs.
  double get _contentWidth {
    final box = _navKey.currentContext?.findRenderObject() as RenderBox?;
    final outerWidth = box?.size.width ?? 0;
    return (outerWidth - 2 * _contentOffsetX).clamp(0, double.infinity);
  }

  int _indexFromContentX(double contentX) {
    final width = _contentWidth;
    if (width <= 0) return _index;
    return (contentX / width * 5).floor().clamp(0, 4);
  }

  void _onTapDown(TapDownDetails details) {
    _updateDrag(details.localPosition.dx - _contentOffsetX);
  }

  void _onTapUp(TapUpDetails details) {
    _commitSelection();
  }

  void _onPanStart(DragStartDetails details) {
    _updateDrag(details.localPosition.dx - _contentOffsetX);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _updateDrag(details.localPosition.dx - _contentOffsetX);
  }

  void _onPanEnd(DragEndDetails details) {
    _commitSelection();
  }

  void _onPanCancel() {
    setState(() {
      _dragIndex = null;
      _dragLocalX = null;
    });
  }

  void _updateDrag(double contentX) {
    setState(() {
      _dragLocalX = contentX;
      _dragIndex = _indexFromContentX(contentX);
    });
  }

  void _commitSelection() {
    final idx = _dragIndex ?? _index;
    setState(() {
      _dragIndex = null;
      _dragLocalX = null;
      if (idx != 2) _index = idx;
    });
    if (idx == 2) _openTimerSheet();
  }

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
          IndexedStack(
            index: _index,
            children: [
              for (var i = 0; i < _pages.length; i++)
                PageVisibility(visible: _index == i, child: _pages[i]),
            ],
          ),
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
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      onPanCancel: _onPanCancel,
      child: Container(
        key: _navKey,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: _navPadding,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(111),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            return Stack(
              children: [
                _buildDragPill(barWidth),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (i) => _buildTab(i, barWidth)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // The pill's actual on-screen center x, clamped to stay fully inside the
  // bar. Shared by the sliding pill and each tab's icon-highlight check so
  // the two stay visually consistent.
  double _pillCenterX(double barWidth) {
    final slotWidth = barWidth / 5;
    final settledCenterX = (_index.clamp(0, 4) + 0.5) * slotWidth;
    final maxCenterX = barWidth > _dragPillSize
        ? barWidth - _dragPillSize / 2
        : _dragPillSize / 2;
    return (_dragLocalX ?? settledCenterX).clamp(_dragPillSize / 2, maxCenterX);
  }

  /// The single highlight that slides beneath the icons while dragging.
  /// It hands off to each tab's own pill once the drag ends.
  Widget _buildDragPill(double barWidth) {
    final isDragging = _dragLocalX != null;
    final hoveringCenter = _dragIndex == 2;
    final centerX = _pillCenterX(barWidth);

    return AnimatedPositioned(
      duration: isDragging ? Duration.zero : const Duration(milliseconds: 320),
      // A slight overshoot-and-settle on release/commit reads as a soft
      // spring rather than a mechanical linear stop.
      curve: Curves.easeOutBack,
      left: centerX - _dragPillSize / 2,
      top: 0,
      width: _dragPillSize,
      height: 44,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        opacity: isDragging && !hoveringCenter ? 1 : 0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.accentLime,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

  // Icons live near the center of their slot, but slot *index* flips at
  // the slot boundary — long before the pill visually reaches the next
  // icon. This returns a continuous 0..1 "how highlighted" value driven by
  // actual pixel overlap between the pill circle and the icon:
  //  - 0 while the pill hasn't touched the icon yet
  //  - ramps up as the icon starts entering the pill
  //  - 1 once the icon is fully enclosed inside the pill
  // instead of an abrupt binary flip at the slot midpoint.
  double _overlapT(int i, double barWidth) {
    final slotWidth = barWidth / 5;
    final slotCenterX = (i + 0.5) * slotWidth;
    const iconHalfWidth = 9.0; // half of the 18px icon
    final pillRadius = _dragPillSize / 2;
    // "outer": pill edge first touches icon edge (icon starts entering).
    // "inner": icon is fully swallowed by the pill (fully entered).
    final outer = pillRadius + iconHalfWidth;
    final inner = (pillRadius - iconHalfWidth).clamp(0.0, outer);
    final distance = (_pillCenterX(barWidth) - slotCenterX).abs();
    if (outer <= inner) return distance <= inner ? 1 : 0;
    final t = ((outer - distance) / (outer - inner)).clamp(0.0, 1.0);
    return t * t * (3 - 2 * t); // smoothstep for an eased, less linear feel
  }

  Widget _buildTab(int i, double barWidth) {
    final isCenter = i == 2;
    final active = _index == i;
    final isDragging = _dragLocalX != null;
    final highlightT = isCenter
        ? 1.0
        : isDragging
        ? _overlapT(i, barWidth)
        : (active ? 1.0 : 0.0);
    // The sliding drag pill owns the highlight while dragging; this tab's
    // own pill only takes over once a selection is committed.
    final showOwnPill = isCenter || (!isDragging && active);
    final showLabel = !isCenter && !isDragging && active;

    return InkWell(
      onTap: () => isCenter ? _openTimerSheet() : setState(() => _index = i),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        height: 44,
        curve: Curves.easeOut,
        duration: isDragging
            ? Duration.zero
            : const Duration(milliseconds: 200),
        padding: showOwnPill
            ? const EdgeInsets.symmetric(horizontal: 16)
            : const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: showOwnPill
              ? (isCenter ? AppColors.background : AppColors.accentLime)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TweenAnimationBuilder (not AnimatedContainer, which only
            // animates its own decoration) so the icon color itself eases
            // between states on tap, matching every other part of the tab.
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: highlightT),
              duration: isDragging
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              builder: (context, t, child) => Icon(
                _icons[i],
                size: 18,
                color: Color.lerp(
                  AppColors.textSecondary,
                  AppColors.primary,
                  t,
                ),
              ),
            ),
            if (_labels[i].isNotEmpty) _buildLabel(i, isDragging, showLabel),
          ],
        ),
      ),
    );
  }

  // Swapped for a plain SizedBox while dragging (rather than just zeroing
  // AnimatedSize's duration) — RenderAnimatedSize forbids resizing itself
  // synchronously mid-layout, which a same-frame duration-to-zero +
  // target-size change can trigger. Labels never animate mid-drag anyway.
  Widget _buildLabel(int i, bool isDragging, bool showLabel) {
    if (isDragging) return const SizedBox.shrink();
    return AnimatedSize(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 250),
      child: SizedBox(
        width: showLabel ? null : 0,
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
    );
  }
}

import 'package:fitness_tracker_app/app.dart';
import 'package:fitness_tracker_app/features/profile/presentation/page/profile_page.dart';
import 'package:fitness_tracker_app/features/progress/presentation/page/progress_page.dart';
import 'package:fitness_tracker_app/features/today/presentation/page/today_page.dart';
import 'package:fitness_tracker_app/features/workouts/presentation/page/workouts_page.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// iPhone 17 Pro logical size (1206x2622 physical @3x).
const _size = Size(402, 874);

void main() {
  // ── Each page renders without RenderFlex overflow ──────────────
  group('pages render without overflow', () {
    for (final page in <Widget>[
      const TodayPage(),
      const WorkoutsPage(),
      const ProgressPage(),
      const ProfilePage(),
    ]) {
      testWidgets('${page.runtimeType}', (tester) async {
        await tester.binding.setSurfaceSize(_size);
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(fontFamily: AppFont.inter),
            home: Scaffold(body: page),
          ),
        );
        await tester.pump();

        expect(
          tester.takeException(),
          isNull,
          reason: '${page.runtimeType} should render without exceptions',
        );
      });
    }
  });

  // ── Switching every tab never throws ───────────────────────────
  testWidgets('bottom nav switches all 5 tabs without exceptions', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(_size);
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const App());
    await tester.pump();

    final icons = <IconData>[
      LucideIcons.house,
      LucideIcons.dumbbell,
      LucideIcons.plus,
      LucideIcons.chartNoAxesColumn,
      LucideIcons.user,
    ];

    for (final icon in icons) {
      // Nav icons are always 18px; pages reuse some icons at other sizes.
      final finder = find.byWidgetPredicate(
        (w) => w is Icon && w.icon == icon && w.size == 18,
      );
      expect(finder, findsOneWidget, reason: 'nav bar has tab $icon');
      await tester.tap(finder, warnIfMissed: false);
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      expect(
        tester.takeException(),
        isNull,
        reason: 'no exceptions after switching tabs',
      );
    }
  });
}

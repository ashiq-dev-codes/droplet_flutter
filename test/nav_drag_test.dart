import 'package:fitness_tracker_app/features/navigation/presentation/page/bottom_navbar.dart';
import 'package:fitness_tracker_app/shared/theme/app_colors.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void main() {
  testWidgets('drag pill glides continuously and commits on release', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(402, 874));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: AppFont.inter),
        home: const Scaffold(
          extendBody: true,
          body: SizedBox.expand(),
          bottomNavigationBar: BottomNavBar(),
        ),
      ),
    );
    await tester.pump();

    final barFinder = find.byType(AnimatedPositioned);
    expect(barFinder, findsOneWidget);

    double leftOf() => tester.widget<AnimatedPositioned>(barFinder).left ?? -1;

    final barBox = tester.getRect(
      find.byWidgetPredicate(
        (w) => w is GestureDetector && w.onPanStart != null,
      ),
    );

    // Start and move within the bar's interior, away from the pill's
    // clamped edges, so each step maps to a distinct pill position.
    final gesture = await tester.startGesture(
      Offset(barBox.left + barBox.width * 0.25, barBox.center.dy),
    );
    await tester.pump();
    final leftAtStart = leftOf();

    await gesture.moveTo(
      Offset(barBox.left + barBox.width * 0.45, barBox.center.dy),
    );
    await tester.pump();
    final leftAfterSmallMove = leftOf();

    await gesture.moveTo(
      Offset(barBox.left + barBox.width * 0.9, barBox.center.dy),
    );
    await tester.pump();
    final leftNearEnd = leftOf();

    // The pill should track the finger continuously, not jump between a
    // handful of discrete slot positions.
    expect(leftAfterSmallMove, greaterThan(leftAtStart));
    expect(leftNearEnd, greaterThan(leftAfterSmallMove));

    await gesture.up();
    await tester.pumpAndSettle();

    // Releasing near the far edge should commit the last tab (Profile).
    expect(
      find.descendant(
        of: find.byWidgetPredicate(
          (w) => w is GestureDetector && w.onPanStart != null,
        ),
        matching: find.text('Profile'),
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'icon only darkens once the pill actually reaches it, not at the slot boundary',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(402, 874));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(fontFamily: AppFont.inter),
          home: const Scaffold(
            extendBody: true,
            body: SizedBox.expand(),
            bottomNavigationBar: BottomNavBar(),
          ),
        ),
      );
      await tester.pump();

      final barBox = tester.getRect(
        find.byWidgetPredicate(
          (w) => w is GestureDetector && w.onPanStart != null,
        ),
      );

      Color workoutsIconColor() => tester
          .widget<Icon>(
            find.byWidgetPredicate(
              (w) => w is Icon && w.icon == LucideIcons.dumbbell,
            ),
          )
          .color!;

      // Just barely past the Today/Workouts slot boundary (20% across):
      // the slot index has already flipped to Workouts, but the pill
      // (still centered near 10%) hasn't visually reached the icon yet.
      final gesture = await tester.startGesture(
        Offset(barBox.left + barBox.width * 0.21, barBox.center.dy),
      );
      await tester.pump();
      expect(
        workoutsIconColor(),
        AppColors.textSecondary,
        reason: 'icon should stay dim until the pill actually overlaps it',
      );

      // Move until the pill is centered on the Workouts slot (30%).
      await gesture.moveTo(
        Offset(barBox.left + barBox.width * 0.3, barBox.center.dy),
      );
      await tester.pump();
      expect(workoutsIconColor(), AppColors.primary);

      await gesture.up();
      await tester.pumpAndSettle();
    },
  );

  testWidgets('tap-and-hold (no movement) triggers the pill immediately', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(402, 874));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: AppFont.inter),
        home: const Scaffold(
          extendBody: true,
          body: SizedBox.expand(),
          bottomNavigationBar: BottomNavBar(),
        ),
      ),
    );
    await tester.pump();

    final barBox = tester.getRect(
      find.byWidgetPredicate(
        (w) => w is GestureDetector && w.onPanStart != null,
      ),
    );

    // Press on the "Workouts" slot (second of five) and hold without
    // moving — should show the hover pill without needing a drag.
    final workoutsX = barBox.left + barBox.width * 0.3;
    final gesture = await tester.startGesture(
      Offset(workoutsX, barBox.center.dy),
    );
    await tester.pump();

    final pill = tester.widget<AnimatedPositioned>(
      find.byType(AnimatedPositioned),
    );
    expect(pill.left, isNotNull);

    await gesture.up();
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byWidgetPredicate(
          (w) => w is GestureDetector && w.onPanStart != null,
        ),
        matching: find.text('Workouts'),
      ),
      findsOneWidget,
    );
  });
}

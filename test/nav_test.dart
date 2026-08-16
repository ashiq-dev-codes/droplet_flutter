import 'package:fitness_tracker_app/features/navigation/presentation/page/bottom_navbar.dart';
import 'package:fitness_tracker_app/shared/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void main() {
  testWidgets('nav bar alone switches tabs without overflow', (tester) async {
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

    final icons = <IconData>[
      LucideIcons.house,
      LucideIcons.dumbbell,
      LucideIcons.plus,
      LucideIcons.chartNoAxesColumn,
      LucideIcons.user,
    ];

    for (final icon in icons) {
      final finder = find.byWidgetPredicate(
        (w) => w is Icon && w.icon == icon && w.size == 18,
      );
      await tester.tap(finder, warnIfMissed: false);
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
      final e = tester.takeException();
      if (e is FlutterError) {
        debugPrint('ERROR on tab $icon: ${e.toString()}');
      }
      expect(e, isNull, reason: 'no overflow while switching to $icon');
    }
  });
}

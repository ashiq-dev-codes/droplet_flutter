import 'package:flutter/widgets.dart';

/// Broadcasts whether the wrapped page is the active tab in an
/// [IndexedStack].
///
/// Geometry-based visibility detection doesn't work for this: IndexedStack
/// lays out every child identically and only skips painting/hit-testing the
/// inactive ones, so an inactive page reports the same size and offset as
/// the active one.
class PageVisibility extends InheritedWidget {
  const PageVisibility({
    super.key,
    required this.visible,
    required super.child,
  });

  final bool visible;

  static bool of(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<PageVisibility>();
    return widget?.visible ?? true;
  }

  @override
  bool updateShouldNotify(PageVisibility oldWidget) =>
      visible != oldWidget.visible;
}

/// Calls [onBecomeVisible] whenever the nearest [PageVisibility] flips to
/// visible, including the first build if already visible.
mixin PageVisibilityMixin<T extends StatefulWidget> on State<T> {
  bool _wasVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final visible = PageVisibility.of(context);
    if (visible && !_wasVisible) {
      onBecomeVisible();
    }
    _wasVisible = visible;
  }

  void onBecomeVisible();
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// Load the real app fonts so text metrics match the device render.
/// Without this, tests use the Ahem placeholder font whose oversized glyphs
/// produce false RenderFlex overflows.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  for (final entry in <(String, String)>[
    ('Space Grotesk', 'assets/fonts/SpaceGrotesk-Variable.ttf'),
    ('Inter', 'assets/fonts/Inter-Variable.ttf'),
  ]) {
    final (family, path) = entry;
    final bytes = File(path).readAsBytesSync();
    final loader = FontLoader(family)
      ..addFont(Future.value(ByteData.view(bytes.buffer)));
    await loader.load();
  }

  await testMain();
}

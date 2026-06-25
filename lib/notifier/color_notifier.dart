import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:flutter_theme_color_check/store/color_store.dart';

final colorProvider = ChangeNotifierProvider<ColorNotifier>((ref) {
  return ColorNotifier();
});

class ColorNotifier with ChangeNotifier {
  // --- ref ---
  final ColorStore _settting = ColorStore();

  // --- public ---
  Iterable<String> get list => _settting.list.keys;

  Color get_color(String key) {
    return Color(int.parse(_settting.get_color(key)));
  }

  Future set_color(String key, Color val) async {
    await _settting.set_and_saveSetting(key, _toHex(val));
    notifyListeners();
  }

  ColorScheme get schemeL =>
      ColorScheme.fromSeed(
        seedColor: get_color('COLOR_SEED'),
        brightness: Brightness.light,
      ).copyWith(
        primary: get_color('COLOR_PRIMARY'),
        secondary: get_color('COLOR_SECONDARY'),
        tertiary: get_color('COLOR_TERTIARY'),
        primaryContainer: get_color('COLOR_PRIMARY_CONTAINER_L'),
        surface: get_color('COLOR_SURFACE_L'),
        surfaceBright: get_color('COLOR_SURFACE_BRIGHT_L'),
        onSurface: get_color('COLOR_ONSURFACE_L'),
        error: get_color('COLOR_ERROR'),
      );

  ThemeData get themeL => ThemeData(
    useMaterial3: true,
    colorScheme: schemeL,
    // appBarTheme       : appBarThemeL,
    // textButtonTheme   : textButtonThemeL,
  );

  ColorScheme get schemeD =>
      ColorScheme.fromSeed(
        seedColor: get_color('COLOR_SEED'),
        brightness: Brightness.light,
      ).copyWith(
        primary: get_color('COLOR_PRIMARY'),
        secondary: get_color('COLOR_SECONDARY'),
        tertiary: get_color('COLOR_TERTIARY'),
        primaryContainer: get_color('COLOR_PRIMARY_CONTAINER_D'),
        surface: get_color('COLOR_SURFACE_D'),
        surfaceBright: get_color('COLOR_SURFACE_BRIGHT_D'),
        onSurface: get_color('COLOR_ONSURFACE_D'),
        error: get_color('COLOR_ERROR'),
      );

  ThemeData get themeD => ThemeData(
    useMaterial3: true,
    colorScheme: schemeD,
    // appBarTheme       : appBarThemeD,
    // textButtonTheme   : textButtonThemeD,
  );

  Future<void> resetAllSetting() async {
    await _settting.resetAllSetting();
  }

  Future<void> readAllSetting() async {
    await _settting.readAllSetting();
  }

  // --- private ---
  String _toHex(Color col) =>
      '0x'
      '${col.alpha8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.red8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.green8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.blue8bit.toRadixString(16).padLeft(2, '0')}';
}

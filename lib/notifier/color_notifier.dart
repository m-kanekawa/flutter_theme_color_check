import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:flutter_theme_color_check/store/color_store.dart';
import 'package:flutter_theme_color_check/store/use_store.dart';

// !!! Warning !!!
// set
//   "editor.formatOnSave": false,"
// in .vscode/settings.json
// when save this file
//
// I really hate dart formatter remove spaces between.
//

final colorProvider = ChangeNotifierProvider<ColorNotifier>((ref) {
  return ColorNotifier();
});

class ColorNotifier with ChangeNotifier {
  // --- ref ---
  final ColorStore _color = ColorStore();
  final UseStore _use = UseStore();

  // --- public ---
  Map<String, dynamic> get list_color => _color.list;
  Map<String, dynamic> get list_use => _use.list;

  String get_color_string(String key) {
    return _color.get_value(key);
  }

  Color get_color(String key) {
    String val = get_color_string(key);
    return Color(int.parse(val.isEmpty ? '0xFF000000' : val));
  }

  Color? get_color_or_null(String key) {
    String key_u = 'U_$key';
    String val = get_color_string(key);
    return _use.get_value(key_u) ? Color(int.parse(val)) : null;
  }

  String get_color_code(String key) {
    String key_u = 'U_$key';
    return _use.get_value(key_u) ? 'Color(${get_color_string(key)})' : 'null';
  }

  Future set_color(String key, Color val) async {
    await _color.set_and_saveSetting(key, _toHex(val));
    notifyListeners();
  }

  Future set_use(String key_u, bool val) async {
    await _use.set_and_saveSetting(key_u, val);
    notifyListeners();
  }

  ColorScheme get schemeL =>
      ColorScheme.fromSeed(
        seedColor        : get_color('COLOR_SEED_L'),
        brightness       : Brightness.light,
      ).copyWith(
        primary          : get_color('COLOR_PRIMARY_L'),
        secondary        : get_color('COLOR_SECONDARY_L'),
        tertiary         : get_color('COLOR_TERTIARY_L'),
        primaryContainer : get_color('COLOR_PRIMARY_CONTAINER_L'),
        surface          : get_color('COLOR_SURFACE_L'),
        surfaceBright    : get_color('COLOR_SURFACE_BRIGHT_L'),
        onSurface        : get_color('COLOR_ONSURFACE_L'),
        error            : get_color('COLOR_ERROR_L'),
      );
  ThemeData get themeL => ThemeData(useMaterial3: true, colorScheme: schemeL);

  ColorScheme get schemeD =>
      ColorScheme.fromSeed(
        seedColor        : get_color('COLOR_SEED_D'),
        brightness       : Brightness.light,
      ).copyWith(
        primary          : get_color('COLOR_PRIMARY_D'),
        secondary        : get_color('COLOR_SECONDARY_D'),
        tertiary         : get_color('COLOR_TERTIARY_D'),
        primaryContainer : get_color('COLOR_PRIMARY_CONTAINER_D'),
        surface          : get_color('COLOR_SURFACE_D'),
        surfaceBright    : get_color('COLOR_SURFACE_BRIGHT_D'),
        onSurface        : get_color('COLOR_ONSURFACE_D'),
        error            : get_color('COLOR_ERROR_D'),
      );
  ThemeData get themeD => ThemeData(useMaterial3: true, colorScheme: schemeD);

  Future<void> resetAllSetting() async {
    await _color.resetAllSetting();
    await _use.resetAllSetting();
  }

  Future<void> readAllSetting() async {
    await _color.readAllSetting();
    await _use.readAllSetting();
    notifyListeners();
  }

  // --- private ---
  String _toHex(Color col) =>
      '0x'
      '${col.alpha8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.red8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.green8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.blue8bit.toRadixString(16).padLeft(2, '0')}';
}

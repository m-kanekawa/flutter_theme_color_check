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
  final UseStore   _use   = UseStore();

  // --- public ---
  Map<String, dynamic> get list_color => _color.list;
  Map<String, dynamic> get list_use   => _use.list;

  String get_color_string(String key) {
    String val = _color.get_value(key);
    return val.isEmpty ? '0xFF000000' : val;
  }

  Color get_color(String key) {
    String val = get_color_string(key);
    return Color(int.parse(val));
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

  ColorScheme scheme(Brightness brightness){

    String x = (brightness == Brightness.light) ? 'L' : 'D';
    return ColorScheme.fromSeed(
        seedColor               : get_color('seed_$x'),
        brightness              : brightness,
      ).copyWith(
        // ----------------------------------------------------------
        // I don't know how to write code below using ColorSchemeList 
        // ----------------------------------------------------------
        primary                 : get_color_or_null('primary_$x'),
        onPrimary               : get_color_or_null('onPrimary_$x'),
        primaryContainer        : get_color_or_null('primaryContainer_$x'),
        onPrimaryContainer      : get_color_or_null('onPrimaryContainer_$x'),
        primaryFixed            : get_color_or_null('primaryFixed_$x'),
        primaryFixedDim         : get_color_or_null('primaryFixedDim_$x'),
        onPrimaryFixed          : get_color_or_null('onPrimaryFixed_$x'),
        onPrimaryFixedVariant   : get_color_or_null('onPrimaryFixedVariant_$x'),
        secondary               : get_color_or_null('secondary_$x'),
        onSecondary             : get_color_or_null('onSecondary_$x'),
        onSecondaryContainer    : get_color_or_null('onSecondaryContainer_$x'),
        secondaryFixed          : get_color_or_null('secondaryFixed_$x'),
        secondaryFixedDim       : get_color_or_null('secondaryFixedDim_$x'),
        onSecondaryFixed        : get_color_or_null('onSecondaryFixed_$x'),
        onSecondaryFixedVariant : get_color_or_null('onSecondaryFixedVariant_$x'),
        tertiary                : get_color_or_null('tertiary_$x'),
        onTertiary              : get_color_or_null('onTertiary_$x'),
        tertiaryContainer       : get_color_or_null('tertiaryContainer_$x'),
        onTertiaryContainer     : get_color_or_null('onTertiaryContainer_$x'),
        tertiaryFixed           : get_color_or_null('tertiaryFixed_$x'),
        tertiaryFixedDim        : get_color_or_null('tertiaryFixedDim_$x'),
        onTertiaryFixed         : get_color_or_null('onTertiaryFixed_$x'),
        onTertiaryFixedVariant  : get_color_or_null('onTertiaryFixedVariant_$x'),
        error                   : get_color_or_null('error_$x'),
        onError                 : get_color_or_null('onError_$x'),
        errorContainer          : get_color_or_null('errorContainer_$x'),
        onErrorContainer        : get_color_or_null('onErrorContainer_$x'),
        outline                 : get_color_or_null('outline_$x'),
        outlineVariant          : get_color_or_null('outlineVariant_$x'),
        surface                 : get_color_or_null('surface_$x'),
        onSurface               : get_color_or_null('onSurface_$x'),
        surfaceDim              : get_color_or_null('surfaceDim_$x'),
        surfaceBright           : get_color_or_null('surfaceBright_$x'),
        surfaceContainerLowest  : get_color_or_null('surfaceContainerLowest_$x'),
        surfaceContainerLow     : get_color_or_null('surfaceContainerLow_$x'),
        surfaceContainer        : get_color_or_null('surfaceContainer_$x'),
        surfaceContainerHigh    : get_color_or_null('surfaceContainerHigh_$x'),
        surfaceContainerHighest : get_color_or_null('surfaceContainerHighest_$x'),
        onSurfaceVariant        : get_color_or_null('onSurfaceVariant_$x'),
        inverseSurface          : get_color_or_null('inverseSurface_$x'),
        onInverseSurface        : get_color_or_null('onInverseSurface_$x'),
        inversePrimary          : get_color_or_null('inversePrimary_$x'),
        shadow                  : get_color_or_null('shadow_$x'),
        scrim                   : get_color_or_null('scrim_$x'),
        surfaceTint             : get_color_or_null('surfaceTint_$x'),
      );
  }

  ColorScheme get schemeL => scheme(Brightness.light);
  ColorScheme get schemeD => scheme(Brightness.dark);

  ThemeData get themeL => ThemeData(useMaterial3: true, colorScheme: schemeL);
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

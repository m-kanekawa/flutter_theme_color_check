import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:flutter_theme_color_check/store/color_store.dart';

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
  final ColorStore _settting = ColorStore();

  // --- public ---
  final List<String> listL = [
    'COLOR_SEED_L',
    'COLOR_PRIMARY_L',
    'COLOR_SECONDARY_L',
    'COLOR_TERTIARY_L',
    'COLOR_SURFACE_L',
    'COLOR_SURFACE_BRIGHT_L',
    'COLOR_ONSURFACE_L',
    'COLOR_PRIMARY_CONTAINER_L',
    'COLOR_ERROR_L',
  ];

  final List<String> listD = [
    'COLOR_SEED_D',
    'COLOR_PRIMARY_D',
    'COLOR_SECONDARY_D',
    'COLOR_TERTIARY_D',
    'COLOR_SURFACE_D',
    'COLOR_SURFACE_BRIGHT_D',
    'COLOR_ONSURFACE_D',
    'COLOR_PRIMARY_CONTAINER_D',
    'COLOR_ERROR_D',
  ];

  Map<String, bool> listSame = {
    'COLOR_SEED_D'              : false,
    'COLOR_PRIMARY_D'           : false,
    'COLOR_SECONDARY_D'         : false,
    'COLOR_TERTIARY_D'          : false,
    'COLOR_SURFACE_D'           : false,
    'COLOR_SURFACE_BRIGHT_D'    : false,
    'COLOR_ONSURFACE_D'         : false,
    'COLOR_PRIMARY_CONTAINER_D' : false,
    'COLOR_ERROR_D'             : false,
  };

  String get_value(String key) {
    return _settting.get_value(key);
  }

  Color get_color(String key) {
    return Color(int.parse(_settting.get_value(key)));
  }

  Future set_value(String key, String val) async {
    await _settting.set_and_saveSetting(key, val);
    notifyListeners();
  }

  Future set_color(String key, Color val) async {
    await _settting.set_and_saveSetting(key, _toHex(val));
    notifyListeners();
  }

  void set_same(String key_d, bool val) {
    listSame[key_d] = val;
    if(val){
      String key_l = key_d.replaceAll('_D', '_L');
      String val_l = get_value(key_l);
      set_value(key_d, val_l);
    }
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
    await _settting.resetAllSetting();
  }

  Future<void> readAllSetting() async {
    await _settting.readAllSetting();
    _init_list_same();
    notifyListeners();
  }

  // --- private ---
  String _toHex(Color col) =>
      '0x'
      '${col.alpha8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.red8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.green8bit.toRadixString(16).padLeft(2, '0')}'
      '${col.blue8bit.toRadixString(16).padLeft(2, '0')}';

  void _init_list_same(){
    for (var key_d in listSame.keys) {
      String key_l = key_d.replaceAll('_D', '_L');
      String val_d = get_value(key_d);
      String val_l = get_value(key_l);
      listSame[key_d] = (val_d == val_l);
    }
  }
}

import 'package:flutter_theme_color_check/base/preferences.dart';

final Map<String, dynamic> jsonSetting = {
  'COLOR_SEED': '0xFFA8A8A8',
  'COLOR_PRIMARY': '0xFF8BC34A',
  'COLOR_SECONDARY': '0xFF4BC3BF',
  'COLOR_TERTIARY': '0xFFC34B4F',
  'COLOR_SURFACE_L': '0xFFFFFFFF',
  'COLOR_SURFACE_D': '0xFF1C1C1C',
  'COLOR_SURFACE_BRIGHT_L': '0xFFF8F8F8',
  'COLOR_SURFACE_BRIGHT_D': '0xFF282828',
  'COLOR_ONSURFACE_L': '0xFF6E6E6E',
  'COLOR_ONSURFACE_D': '0xFFF8F8F8',
  'COLOR_PRIMARY_CONTAINER_L': '0xFFBCDD98',
  'COLOR_PRIMARY_CONTAINER_D': '0xFF577E2A',
  'COLOR_ERROR': '0xFFEF5350',
};

class ColorStore with MkPreference {
  // --- singleton ---
  ColorStore._() {
    set_list();
  }
  static final ColorStore _instance = ColorStore._();
  factory ColorStore() {
    return _instance;
  }

  // --- member ---
  String get_color(String key) {
    return list[key];
  }

  // --- private ---
  @override
  void set_list() {
    super.list = jsonSetting;
  }
}

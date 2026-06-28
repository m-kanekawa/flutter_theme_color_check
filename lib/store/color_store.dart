import 'package:flutter_theme_color_check/base/preferences.dart';
import 'package:flutter_theme_color_check/base/color_scheme.dart';

// String value of HEX for Color for each of ColorSchemeList
// Empty value allowed.
//
// For example, "primary" has 2 values,
// {primary_L : '0xFFA8A8A8', primary_D : ''}

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
  String get_value(String key) {
    return list[key];
  }

  // --- private ---
  @override
  void set_list() {
    Map<String, dynamic> tmp = {'seed_L': '0xFFA8A8A8', 'seed_D': '0xFFA8A8A8'};
    for (int i = 0; i < ColorSchemeList.length; i++) {
      var keyL = '${ColorSchemeList[i]}_L';
      var keyD = '${ColorSchemeList[i]}_D';
      tmp.addAll({keyL: '', keyD: ''});
    }
    super.list = tmp;
  }
}

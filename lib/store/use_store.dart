import 'package:flutter_theme_color_check/base/preferences.dart';
import 'package:flutter_theme_color_check/base/color_scheme.dart';

// Bool value for each of ColorSchemeList
// which indicate using the element or not.
// Key starts with "U_" to distinguish keys of ColorStore
//
// For example, "primary" has 2 values,
// {U_primary_L : true, U_primary_D : false}

class UseStore with MkPreference {
  // --- singleton ---
  UseStore._() {
    set_list();
  }
  static final UseStore _instance = UseStore._();
  factory UseStore() {
    return _instance;
  }

  // --- member ---
  bool get_value(String key) {
    return list[key];
  }

  // --- private ---
  @override
  void set_list() {
    Map<String, dynamic> tmp = {'U_seed_L': true, 'U_seed_D': true};
    // U_seed_L, U_seed_D are allways true!

    for (int i = 0; i < Const.ColorSchemeList.length; i++) {
      var keyL = 'U_${Const.ColorSchemeList[i]}_L';
      var keyD = 'U_${Const.ColorSchemeList[i]}_D';
      tmp.addAll({keyL: false, keyD: false});
    }
    super.list = tmp;
  }
}

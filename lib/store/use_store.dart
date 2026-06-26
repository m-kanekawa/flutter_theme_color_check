import 'package:flutter_theme_color_check/base/preferences.dart';

// !!! Warning !!!
// set
//   "editor.formatOnSave": false,"
// in .vscode/settings.json
// when save this file
//
// I really hate dart formatter remove spaces between.
//

final Map<String, dynamic> jsonSetting = {
  'U_COLOR_SEED_L'              : true,
  'U_COLOR_PRIMARY_L'           : true,
  'U_COLOR_SECONDARY_L'         : true,
  'U_COLOR_TERTIARY_L'          : true,
  'U_COLOR_SURFACE_L'           : true,
  'U_COLOR_SURFACE_BRIGHT_L'    : true,
  'U_COLOR_ONSURFACE_L'         : true,
  'U_COLOR_PRIMARY_CONTAINER_L' : true,
  'U_COLOR_ERROR_L'             : true,

  'U_COLOR_SEED_D'              : true,
  'U_COLOR_PRIMARY_D'           : true,
  'U_COLOR_SECONDARY_D'         : true,
  'U_COLOR_TERTIARY_D'          : true,
  'U_COLOR_SURFACE_D'           : true,
  'U_COLOR_SURFACE_BRIGHT_D'    : true,
  'U_COLOR_ONSURFACE_D'         : true,
  'U_COLOR_PRIMARY_CONTAINER_D' : true,
  'U_COLOR_ERROR_D'             : true,
};

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
    super.list = jsonSetting;
  }
}

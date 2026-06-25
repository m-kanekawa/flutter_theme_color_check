import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void MkPrint(String s) {
  if (kDebugMode) debugPrint(s);
}

mixin MkPreference {
  Map<String, dynamic> list = {};

  void set_list() {
    throw Exception('override set_list()!!!');
  }

  Future readAllSetting() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    for (var key in list.keys) {
      if (list[key] is bool) {
        list[key] = p.getBool(key) ?? list[key];
      } else if (list[key] is int) {
        list[key] = p.getInt(key) ?? list[key];
      } else if (list[key] is double) {
        list[key] = p.getDouble(key) ?? list[key];
      } else if (list[key] is String) {
        list[key] = p.getString(key) ?? list[key];
      }
      MkPrint('readSetting($key) = ${list[key]}');
    }
  }

  void setVal(String key, var val) {
    list[key] = val;
  }

  Future _saveBool(SharedPreferences p, String key) async {
    bool val = list[key];

    if (val) {
      await p.setBool(key, true);
      MkPrint('saveSettingB($key) = true');
    } else {
      await p.remove(key);
      MkPrint('removeSettingB($key)');
    }
  }

  Future _saveInt(SharedPreferences p, String key) async {
    int val = list[key];

    if (val > 0) {
      await p.setInt(key, val);
      MkPrint('saveSettingI($key) = $val');
    } else {
      await p.remove(key);
      MkPrint('removeSettingI($key)');
    }
  }

  Future _saveDouble(SharedPreferences p, String key) async {
    double val = list[key];

    if (val > 0) {
      await p.setDouble(key, val);
      MkPrint('saveSettingD($key) = ${val.toStringAsFixed(2)}');
    } else {
      await p.remove(key);
      MkPrint('removeSettingD($key)');
    }
  }

  Future _saveString(SharedPreferences p, String key) async {
    String val = list[key];

    if (val.isNotEmpty) {
      await p.setString(key, val);
      MkPrint('saveSettingS($key) = $val');
    } else {
      await p.remove(key);
      MkPrint('removeSettingS($key)');
    }
  }

  Future saveSetting(String key) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    if (list[key] is int) {
      await _saveInt(p, key);
    } else if (list[key] is bool) {
      await _saveBool(p, key);
    } else if (list[key] is double) {
      await _saveDouble(p, key);
    } else if (list[key] is String) {
      await _saveString(p, key);
    }
  }

  Future saveAllSetting() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    for (var key in list.keys) {
      if (list[key] is int) {
        await _saveInt(p, key);
      } else if (list[key] is bool) {
        await _saveBool(p, key);
      } else if (list[key] is double) {
        await _saveDouble(p, key);
      }
    }
  }

  Future set_and_saveSetting(String key, var val) async {
    setVal(key, val);
    await saveSetting(key);
  }

  Future removeAllSetting() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    for (var key in list.keys) {
      MkPrint('remove($key)');
      await p.remove(key);
    }
  }

  Future resetAllSetting() async {
    MkPrint('resetAllSetting');
    set_list();
    await removeAllSetting();
  }
}

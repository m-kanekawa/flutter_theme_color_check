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
      await saveSetting(key, p: p);
    }
  }

  void setVal(String key, var val) {
    list[key] = val;
  }

  Future _saveBool(String key, {SharedPreferences? p}) async {
    p ??= await SharedPreferences.getInstance();
    bool val = list[key];
    await p.setBool(key, val);
    MkPrint('saveSettingB($key) = $val');
  }

  Future _saveInt(String key, {SharedPreferences? p}) async {
    p ??= await SharedPreferences.getInstance();
    int val = list[key];
    await p.setInt(key, val);
    MkPrint('saveSettingI($key) = $val');
  }

  Future _saveDouble(String key, {SharedPreferences? p}) async {
    p ??= await SharedPreferences.getInstance();
    double val = list[key];
    await p.setDouble(key, val);
    MkPrint('saveSettingD($key) = ${val.toStringAsFixed(2)}');
  }

  Future _saveString(String key, {SharedPreferences? p}) async {
    p ??= await SharedPreferences.getInstance();
    String val = list[key];
    await p.setString(key, val);
    MkPrint('saveSettingS($key) = $val');
  }

  Future saveSetting(String key, {SharedPreferences? p}) async {
    p ??= await SharedPreferences.getInstance();
    if (list[key] is int) {
      await _saveInt(key, p: p);
    } else if (list[key] is bool) {
      await _saveBool(key, p: p);
    } else if (list[key] is double) {
      await _saveDouble(key, p: p);
    } else if (list[key] is String) {
      await _saveString(key, p: p);
    }
  }

  Future saveAllSetting({SharedPreferences? p}) async {
    p ??= await SharedPreferences.getInstance();
    for (var key in list.keys) {
      saveSetting(key, p: p);
    }
  }

  Future set_and_saveSetting(String key, var val) async {
    setVal(key, val);
    await saveSetting(key);
  }

  Future removeAllSetting({SharedPreferences? p}) async {
    p ??= await SharedPreferences.getInstance();
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

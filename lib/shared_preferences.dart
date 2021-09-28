import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  Future<void> saveData(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(value));
  }

  Future<dynamic> getValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    final data = await prefs.getString(key);
    return jsonDecode(data ?? '{}');
  }

  Future<void> deleteKey(String keyName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    for (String key in prefs.getKeys()) {
      if (key == keyName) {
        prefs.remove(key);
      }
    }
  }

  //delete key
  //delete data
}

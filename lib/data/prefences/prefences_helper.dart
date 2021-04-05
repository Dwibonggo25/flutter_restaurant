import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final SharedPreferences sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  static const _isAlarmActive = 'isAlarmActive';

  Future<bool> get getAlarmActive async {
    return sharedPreferences.getBool(_isAlarmActive) ?? false;
  }

  Future setAlarmActive(bool value) async {
    await sharedPreferences.setBool(_isAlarmActive, value);
  }
}
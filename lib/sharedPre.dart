import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static SharedPreferences _sharedPreferences;

  SharedPreferences sharedPreferences;

  static Future<SharedPreferences> getSharedPref() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences;
  }

  static allClear() {
    _sharedPreferences.clear();
  }

  //----------Save location --------------------->

  static void setMasterQuote(List<String> masterQuote) {
    _sharedPreferences.setStringList('masterQuote', masterQuote);
  }

  static List getMasterQuote() {
    return _sharedPreferences.getStringList('masterQuote');
  }
}

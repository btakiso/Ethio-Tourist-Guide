import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) async {
    _themeData = theme;
    notifyListeners();

    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _themeData == ThemeData.dark());
  }

  Future<void> loadTheme() async {
    var prefs = await SharedPreferences.getInstance();
    bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    _themeData = isDarkTheme ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkMode = false;
  bool get isDarkMode => _darkMode;

  Future<bool> getIsDarkModeFromSP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final darkMode = prefs.getBool('darkMode') ?? false;
    _darkMode = darkMode;
    return darkMode;
  }

  void changeDarkMode(newValue) {
    _darkMode = newValue;

    SharedPreferences.getInstance().then((final SharedPreferences prefs) {
      prefs.setBool('darkMode', newValue);
    });

    notifyListeners();
  }
}
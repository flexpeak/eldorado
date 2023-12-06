import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkMode = false;
  bool get isDarkMode => _darkMode;

  void changeDarkMode(newValue) {
    _darkMode = newValue;
    notifyListeners();
  }
}
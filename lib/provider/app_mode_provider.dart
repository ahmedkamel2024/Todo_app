import 'package:flutter/material.dart';

class AppModeProvider extends ChangeNotifier {
  ThemeMode appMode = ThemeMode.light;

  void changeMode(ThemeMode newMode) {
    if (appMode == newMode) {
      return;
    }
    appMode = newMode;
    notifyListeners();
  }

  bool isDarkMode() {
    return appMode == ThemeMode.dark;
  }
}

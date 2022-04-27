import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  //return true if isDarkMode == ThemeMode.dark
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isSwitch) {
    themeMode = isSwitch ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900,titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20.0), iconTheme: const IconThemeData(color: Colors.white)),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white,titleTextStyle: TextStyle(color: Colors.grey.shade900,fontSize: 20.0), iconTheme: const IconThemeData(color: Colors.black)),
  );
}

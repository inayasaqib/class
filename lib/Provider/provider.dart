import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {

  bool _isDark = false;
  bool get isDark => _isDark;

final DarkTheme = ThemeData(
primaryColor: Colors.black12,
brightness: Brightness.dark,
primaryColorDark: Colors.black12
);

final LightTheme = ThemeData(
primaryColor: Colors.white,
brightness: Brightness.light,
primaryColorDark: Colors.white
);

  changeTheme(){
   _isDark = !isDark;
    notifyListeners();
  }

  init(){
    notifyListeners();
  }
}
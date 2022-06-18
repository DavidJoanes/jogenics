import 'package:flutter/material.dart';
import 'package:JoGenics/constants.dart';
// import 'package:theme_provider/theme_provider.dart';

class MyThemes {
  static const primary = primaryColor;
  static const primaryColor = primaryLightColor;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor,
    dividerColor: Colors.white, colorScheme: const ColorScheme.dark(primary: primary).copyWith(secondary: Colors.blue),
  );

  static final lightTheme = ThemeData(
    // scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: Colors.grey.shade900,
  );
}
import 'package:flutter/material.dart';

final MaterialColor kPrimarySwatch =
    MaterialColor(0xFF42224A, const <int, Color>{
  50: kGreyishColor,
  100: Color(0xFFD3C0D8),
  200: Color(0xFFB692BF),
  300: Color(0xFF985EA6),
  400: Color(0xFF6E3E7A),
  500: kPrimaryColor,
  600: Color(0xFF381740),
  700: Color(0xFF2D0E35),
  800: Color(0xFF210727),
  900: kDarkPurpleColor,
});
const Color kPrimaryColor = Color(0xFF42224A);
const Color kSecondaryColor = Color(0xFFEF8767);
const Color kDarkPurpleColor = Color(0xFF120216);
const Color kGreyishColor = Color(0xFFF2EDF3);

final BorderRadius kBorderRadius = BorderRadius.circular(20.0);

final ThemeData kThemeData = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: kDarkPurpleColor,
    centerTitle: true,
    elevation: 1,
    toolbarHeight: 50,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kSecondaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
  ),
  primaryColor: kPrimaryColor,
  primarySwatch: kPrimarySwatch,
  scaffoldBackgroundColor: Colors.white,
);

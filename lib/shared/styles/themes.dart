import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: primaryOrange,
    ),
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: primaryOrange,
    ),
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: Colors.orange,
    //   statusBarIconBrightness: Brightness.dark,
    // ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(
      color: Colors.deepOrange,
      fill: 1.0,
    ),
    backgroundColor: Colors.white,
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: dark,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: primaryOnDark,
    ),
    color: dark,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: primaryOnDark,
    ),
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: dark,
    //   statusBarIconBrightness: Brightness.light,
    // ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedIconTheme: IconThemeData(
      color: primaryOnDark,
    ),
    selectedIconTheme: IconThemeData(
      color: Colors.deepOrange,
      fill: 1.0,
    ),
    backgroundColor: dark,
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: primaryOnDark,
    ),
  ),
);

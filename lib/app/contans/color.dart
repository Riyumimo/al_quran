import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color.fromARGB(255, 55, 22, 135);
const appPurpleLight1 = Color(0xFF9345f2);
const appPurpleLight2 = Color(0xFFB9a2D8);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFE6704A);

ThemeData themeLight = ThemeData(
    brightness: Brightness.light,
    floatingActionButtonTheme:
         const FloatingActionButtonThemeData(backgroundColor: appPurpleDark
        ),
        // ignore: prefer_const_constructors
        tabBarTheme: TabBarTheme(
          labelColor: appPurple,

        ),
    primaryColor: appPurple,
    scaffoldBackgroundColor: Colors.white,
    // ignore: prefer_const_constructors
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: appPurple,
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(color: appPurpleDark),
        bodyText2: TextStyle(color: appPurpleDark)));

ThemeData themeDark = ThemeData(

    brightness: Brightness.dark,
    floatingActionButtonTheme:
         const FloatingActionButtonThemeData(backgroundColor: appWhite
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: appWhite,

        ),
        cardTheme: const CardTheme(
          color: appWhite
        ),
    primaryColor: appPurpleLight2,
    scaffoldBackgroundColor: appPurpleDark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: appPurpleDark,
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(color: appWhite),
        bodyText2: TextStyle(color: appWhite)));

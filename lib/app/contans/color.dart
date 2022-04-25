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
        FloatingActionButtonThemeData(backgroundColor: appPurpleDark
        ),
        tabBarTheme: TabBarTheme(
          labelColor: appPurple,

        ),
    primaryColor: appPurple,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: appPurple,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: appPurpleDark),
        bodyText2: TextStyle(color: appPurpleDark)));

ThemeData themeDark = ThemeData(

    brightness: Brightness.dark,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appWhite
        ),
        tabBarTheme: TabBarTheme(
          labelColor: appWhite,

        ),
        cardTheme: CardTheme(
          color: appWhite
        ),
    primaryColor: appPurpleLight2,
    scaffoldBackgroundColor: appPurpleDark,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: appPurpleDark,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: appWhite),
        bodyText2: TextStyle(color: appWhite)));
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_my_chat_app/config/colors.dart';

var lightTheme = ThemeData();
var darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: darkContainerColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: darkBackgroundColor,
      filled: true,
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      )),
  colorScheme: const ColorScheme.dark(
    primary: darkPrimaryColor,
    onPrimary: darkOnBackgroundColor,
    background: darkBackgroundColor,
    onBackground: darkOnBackgroundColor,
    primaryContainer: darkContainerColor,
    onPrimaryContainer: darkOnContainerColor,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      color: darkPrimaryColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      color: darkOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      color: darkOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      fontSize: 15,
      color: darkOnContainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: darkOnContainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      color: darkOnContainerColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: darkOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: darkOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontSize: 10,
      color: darkOnBackgroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w300,
    ),
  ),
);

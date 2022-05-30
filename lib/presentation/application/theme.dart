import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    toolbarHeight: 40,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: blackColor,
    secondary: secondaryColor,
    onSecondary: whiteColor,
    error: errorColor,
    onError: whiteColor,
    background: backgroundColor,
    onBackground: blackColor,
    surface: whiteColor,
    onSurface: blackColor,
  ),
  backgroundColor: backgroundColor,
  primaryColor: primaryColor,
  textTheme: GoogleFonts.signikaTextTheme(),
);

const primaryColor = Color(0xffd8a476);

const blackColor = Colors.black;

const whiteColor = Colors.white;

const secondaryColor = Color(0xff8d6e63);

const errorColor = Colors.red;

const backgroundColor = Color(0xffffd5a5);

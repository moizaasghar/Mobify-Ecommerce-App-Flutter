import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      cardColor: Colors.white,
      canvasColor: creamColor,
      buttonTheme: ButtonThemeData(buttonColor: darkBluishColor),
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.deepPurple),
          titleTextStyle: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 22.0)),
      colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: darkBluishColor,
          secondary: darkBluishColor));

  static ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.black,
      canvasColor: darkCreamColor,
      buttonTheme: ButtonThemeData(buttonColor: lightBluishColor),
      appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22.0)),
      colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: lightBluishColor,
          secondary: Colors.white));

  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkBluishColor = const Color(0xff403b58);
  static Color darkCreamColor = Vx.gray900;
  static Color lightBluishColor = Vx.indigo400;
}

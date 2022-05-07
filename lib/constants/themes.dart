import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class RegulumThemes {
  static TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.merriweather(fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.merriweather(fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.merriweather(fontSize: 46, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.merriweather(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.merriweather(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.merriweather(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.merriweather(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  static ThemeData ligthTheme = ThemeData(
    textTheme: textTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionHandleColor: Color(0xff25E48E),
      selectionColor: Colors.lightBlueAccent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: const Color(0xff25E48E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(width: 4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      contentPadding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
      labelStyle: const TextStyle(color: Colors.black),
      isDense: true,
      suffixIconColor: Colors.black,
      suffixStyle: RegulumThemes.textTheme.caption,
    ),
    primaryColor: const Color(0xffDBFF02),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffDBFF02),
      primary: const Color(0xffDBFF02),
      onPrimary: Colors.black,
      secondary: const Color(0xff25E48E),
      onSecondary: Colors.black,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff121212),
      primary: const Color(0xffb4b800),
      secondary: const Color(0xff90cc00),
      brightness: Brightness.dark,
    ),
  );
}

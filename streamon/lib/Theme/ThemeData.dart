import 'package:flutter/material.dart';

class PersonalThemeData {
  getLightThemeData() {
    return ThemeData(
      backgroundColor: Color(0xff202020),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: Color(0xffdbebfc),
        ),
    //     headline3: TextStyle(
        //       color: Color(0xff295881),
        // ),

      ),

      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.white,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Colors.white,
        onSurface: Colors.white,
      ),
    );
  }
}

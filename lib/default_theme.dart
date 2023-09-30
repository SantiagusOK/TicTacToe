import 'package:flutter/material.dart';

Color color1 = Colors.blue;
Color color2 = Colors.purple;
Color color3 = Colors.lightGreen;

ThemeData defaultTheme(BuildContext context) => Theme.of(context).copyWith(
    textTheme: TextTheme(
      displayMedium: TextStyle(
          fontFamily: 'AmaticSC',
          color: color1,
          fontSize: 28,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold),
      displayLarge: TextStyle(
          fontFamily: 'AmaticSC',
          color: color2,
          fontSize: 42,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(TextStyle(
                color: color3,
                fontSize: 36,
                fontWeight: FontWeight.w700,
                fontFamily: 'AmaticSC')),
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
            shadowColor: const MaterialStatePropertyAll(Colors.transparent),
            foregroundColor: const MaterialStatePropertyAll(Colors.blue))));

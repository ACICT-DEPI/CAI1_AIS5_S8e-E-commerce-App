// themes.dart
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch:Colors.deepOrange ,  // Replace 'kprimaryColor' with 'Colors.deepPurple'
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.deepOrange ,  // Use 'color' instead of 'backgroundColor'
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepOrange ,
  scaffoldBackgroundColor: HexColor('#1A1A2E'),
  appBarTheme: AppBarTheme(
    color: HexColor('333739'),  // Use 'color' instead of 'backgroundColor'
  ),
);


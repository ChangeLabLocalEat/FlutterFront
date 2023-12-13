import 'package:flutter/material.dart';
import 'package:login/pages/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFf7eeb2),
        appBarTheme: AppBarTheme(
          foregroundColor: Color(0xFF22372e),
          backgroundColor: Color(0xFFf7eeb2),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF663627),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF22372e)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF22372e)),
          ),
        ),
        textSelectionTheme:
        TextSelectionThemeData(cursorColor: Color(0xFF22372e)),
        cardTheme: CardTheme(
          shape: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF22372e))),
        ),
      ),
      home: Menu(),
    );
  }
}


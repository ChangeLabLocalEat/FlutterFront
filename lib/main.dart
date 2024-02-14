import 'package:flutter/material.dart';
import 'package:local_eat/pages/MapPage.dart';
import 'package:local_eat/pages/login.dart';
import 'package:local_eat/pages/menu.dart';
import 'package:local_eat/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => Menu(),
      '/login': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
      '/map': (context) => const MapPage(),
    },
      title: 'Loxi',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFf7eeb2),
        appBarTheme: AppBarTheme(
          foregroundColor: Color(0xFF22372e),
          backgroundColor: Color(0xFFf7eeb2),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF663627),
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
    );
  }
}

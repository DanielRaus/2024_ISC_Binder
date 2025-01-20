import 'package:flutter/material.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookSwipe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B4513), // Saddle Brown
          background: const Color(0xFFF5F5DC), // Beige
        ),
        cardColor: const Color(0xFFFAF0E6), // Linen
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B4513), // Saddle Brown
          foregroundColor: Colors.white,
        ),
      ),
      home: const LandingPage(),
    );
  }
}

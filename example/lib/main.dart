import 'package:example/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TooltipCard Examples',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        extensions: [
          TooltipCardThemeData(
            backgroundColor: Colors.white,
            beakColor: Colors.white,
            elevation: 8.0,
            borderRadius: BorderRadius.circular(12),
            beakSize: 10.0,
            beakInset: 16.0,
            padding: const EdgeInsets.all(4),
            barrierColor: Colors.black38,
            barrierBlur: 2.0,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            subtitleStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
            iconColor: Colors.deepPurple,
            iconSize: 24.0,
            contentMaxWidth: 320.0,
            contentPadding: const EdgeInsets.all(16),
            contentSpacing: 12.0,
            actionSpacing: 8.0,
          ),
        ],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        extensions: [
          TooltipCardThemeData(
            backgroundColor: const Color(0xFF2D2D30),
            beakColor: const Color(0xFF2D2D30),
            elevation: 12.0,
            borderRadius: BorderRadius.circular(12),
            beakSize: 10.0,
            beakInset: 16.0,
            padding: const EdgeInsets.all(4),
            barrierColor: Colors.black54,
            barrierBlur: 3.0,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            subtitleStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
              height: 1.4,
            ),
            iconColor: Colors.deepPurpleAccent,
            iconSize: 24.0,
            contentMaxWidth: 320.0,
            contentPadding: const EdgeInsets.all(16),
            contentSpacing: 12.0,
            actionSpacing: 8.0,
          ),
        ],
      ),
      home: const HomeScreen(),
    );
  }
}

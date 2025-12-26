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
          seedColor: const Color(0xFF4F46E5), // Indigo 600
          brightness: Brightness.light,
          surface: const Color(0xFFF8FAFC), // Slate 50
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        extensions: [
          TooltipCardThemeData(
            backgroundColor: Colors.white,
            beakColor: Colors.white,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(16),
            beakSize: 12.0,
            beakInset: 20.0,
            padding: const EdgeInsets.all(6),
            barrierColor: Colors.black.withValues(alpha: 0.3),
            barrierBlur: 4.0,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B), // Slate 800
              fontFamily: 'Inter',
            ),
            subtitleStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B), // Slate 500
              height: 1.5,
              fontFamily: 'Inter',
            ),
            iconColor: const Color(0xFF4F46E5),
            iconSize: 24.0,
            contentMaxWidth: 340.0,
            contentPadding: const EdgeInsets.all(20),
            contentSpacing: 16.0,
            actionSpacing: 12.0,
          ),
        ],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Indigo 500
          brightness: Brightness.dark,
          surface: const Color(0xFF0F172A), // Slate 900
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        extensions: [
          TooltipCardThemeData(
            backgroundColor: const Color(0xFF1E293B), // Slate 800
            beakColor: const Color(0xFF1E293B),
            elevation: 12.0,
            borderRadius: BorderRadius.circular(16),
            beakSize: 12.0,
            beakInset: 20.0,
            padding: const EdgeInsets.all(6),
            barrierColor: Colors.black.withValues(alpha: 0.6),
            barrierBlur: 6.0,

            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF1F5F9), // Slate 100
              fontFamily: 'Inter',
            ),
            subtitleStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF94A3B8), // Slate 400
              height: 1.5,
              fontFamily: 'Inter',
            ),
            iconColor: const Color(0xFF818CF8), // Indigo 400
            iconSize: 24.0,
            contentMaxWidth: 340.0,
            contentPadding: const EdgeInsets.all(20),
            contentSpacing: 16.0,
            actionSpacing: 12.0,
          ),
        ],
      ),
      // home: const DemoPage(),
      home: const HomeScreen(),
    );
  }
}

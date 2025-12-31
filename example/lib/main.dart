import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';
import 'core/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TooltipCard Examples',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      routerConfig: appRouter,
    );
  }

  ThemeData _buildLightTheme() {
    const seedColor = Color(0xFF6366F1);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
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
          iconColor: seedColor,
          iconSize: 24.0,
          contentMaxWidth: 320.0,
          contentPadding: const EdgeInsets.all(16),
          contentSpacing: 12.0,
          actionSpacing: 8.0,
        ),
      ],
    );
  }

  ThemeData _buildDarkTheme() {
    const seedColor = Color(0xFF6366F1);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
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
          iconColor: const Color(0xFF818CF8),
          iconSize: 24.0,
          contentMaxWidth: 320.0,
          contentPadding: const EdgeInsets.all(16),
          contentSpacing: 12.0,
          actionSpacing: 8.0,
        ),
      ],
    );
  }
}

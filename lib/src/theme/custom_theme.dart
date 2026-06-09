import 'package:flutter/material.dart';

class CustomTheme extends ChangeNotifier {
  bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static const _darkScaffold = Color(0xFF0A0E1A);
  static const _darkCard = Color(0xFF141829);
  static const _accentCyan = Color(0xFF00E5FF);
  static const _accentPurple = Color(0xFFB388FF);
  static const _accentPink = Color(0xFFFF4081);

  static const _lightScaffold = Color(0xFFF5F7FF);
  static const _lightCard = Color(0xFFFFFFFF);
  static const _lightAccent = Color(0xFF6C63FF);
  static const _lightAccent2 = Color(0xFFFF6584);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: _lightScaffold,
      cardColor: _lightCard,
      hoverColor: _lightAccent.withOpacity(0.08),
      primaryColor: _lightAccent,
      primaryColorDark: const Color(0xFF2A2A4A),
      primaryColorLight: const Color(0xFF1A1A2E),
      colorScheme: ColorScheme.light(
        primary: _lightAccent,
        secondary: _lightAccent2,
        surface: _lightCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: const Color(0xFF1A1A2E),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: _darkScaffold,
      cardColor: _darkCard,
      hoverColor: _accentCyan.withOpacity(0.08),
      primaryColor: _accentCyan,
      primaryColorDark: const Color(0xFF6C7582),
      primaryColorLight: const Color(0xFFEEF0FF),
      colorScheme: ColorScheme.dark(
        primary: _accentCyan,
        secondary: _accentPurple,
        tertiary: _accentPink,
        surface: _darkCard,
        onPrimary: const Color(0xFF0A0E1A),
        onSecondary: Colors.white,
        onSurface: const Color(0xFFEEF0FF),
      ),
    );
  }
}

List<Color> primaryGradient = const [Color(0xFF00E5FF), Color(0xFFB388FF)];
List<Color> accentGradient = const [Color(0xFFFF4081), Color(0xFFFF9100)];

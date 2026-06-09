import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'app.dart';
import 'src/configure_web.dart';
import 'src/json_service.dart';
import 'src/theme/config.dart';
import 'src/theme/custom_theme.dart';

void main() {
  configureApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() => setState(() {}));
    jsonService.init();
    jsonService.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: JSONService.hasLoaded == true
          ? const App()
          : const _SplashScreen(),
    );
  }
}

class _SplashScreen extends StatefulWidget {
  const _SplashScreen();
  @override
  State<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? const Color(0xFF0A0E1A)
        : const Color(0xFFF5F7FF);
    final accent = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeController,
          child: AnimatedBuilder(
            animation: Listenable.merge([_pulseController, _rotateController]),
            builder: (context, _) {
              final pulse = _pulseController.value;
              final angle = _rotateController.value * 2 * math.pi;
              final dx = math.sin(angle);
              final dy = math.cos(angle);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120 + pulse * 20,
                    height: 120 + pulse * 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28 + pulse * 4),
                      gradient: LinearGradient(
                        colors: [
                          accent,
                          const Color(0xFFB388FF),
                          const Color(0xFFFF4081),
                          accent,
                        ],
                        begin: Alignment(-dx, -dy),
                        end: Alignment(dx, dy),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.3 + pulse * 0.2),
                          blurRadius: 30 + pulse * 20,
                          spreadRadius: 2 + pulse * 3,
                        ),
                      ],
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: const [Colors.white, Color(0xFFB0BEC5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Center(
                        child: Text(
                          '<JJ />',
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: accent.withValues(alpha: 0.5 + pulse * 0.3),
                      letterSpacing: 4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

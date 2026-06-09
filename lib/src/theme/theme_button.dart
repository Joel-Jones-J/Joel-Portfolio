import 'dart:math';
import 'package:flutter/material.dart';
import 'config.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({Key? key}) : super(key: key);
  @override
  ThemeButtonState createState() => ThemeButtonState();
}

class ThemeButtonState extends State<ThemeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _rotation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = currentTheme.currentTheme == ThemeMode.dark;
    final color = isDark ? const Color(0xFFFFD54F) : const Color(0xFF6C63FF);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (_scale.value - 1) * (1 - _controller.value),
          child: Transform.rotate(
            angle: _rotation.value,
            child: IconButton(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: color,
              iconSize: 26,
              onPressed: () {
                _controller.forward(from: 0);
                currentTheme.toggleTheme();
                setState(() {});
              },
              icon: isDark
                  ? const Icon(Icons.wb_sunny_rounded)
                  : const Icon(Icons.nightlight_round),
            ),
          ),
        );
      },
    );
  }
}

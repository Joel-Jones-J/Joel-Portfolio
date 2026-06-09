import 'package:flutter/material.dart';

class Introduction extends StatelessWidget {
  const Introduction({
    Key? key,
    required this.word,
    required this.textScaleFactor,
  }) : super(key: key);

  final String word;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark
        ? const Color(0xFFEEF0FF).withOpacity(0.7)
        : const Color(0xFF1A1A2E).withOpacity(0.6);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        word,
        textScaler: TextScaler.linear(textScaleFactor),
        style: TextStyle(
          fontFamily: 'SourceCodePro',
          letterSpacing: 2,
          fontWeight: FontWeight.w400,
          color: color,
          height: 1.1,
        ),
      ),
    );
  }
}

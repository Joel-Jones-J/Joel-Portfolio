import 'package:flutter/material.dart';
import 'data.dart';

class About extends StatelessWidget {
  About({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  final double fontSize;
  final String gotAbout = about();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark
              ? const Color(0xFF141829).withOpacity(0.5)
              : const Color(0xFFEEF0FF).withOpacity(0.5),
          border: Border.all(
            color: isDark
                ? const Color(0xFF00E5FF).withOpacity(0.08)
                : const Color(0xFF6C63FF).withOpacity(0.08),
          ),
        ),
        child: Text(
          gotAbout,
          style: TextStyle(
            fontFamily: 'SourceCodePro',
            letterSpacing: 1.5,
            color: Theme.of(context).primaryColorLight.withOpacity(0.85),
            fontSize: fontSize,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}

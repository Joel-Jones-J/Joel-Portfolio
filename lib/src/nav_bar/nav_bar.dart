import 'dart:ui';
import 'package:flutter/material.dart';

import '../theme/theme_button.dart';
import 'nav_bar_btn.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.isDarkModeBtnVisible,
  }) : super(key: key);

  final bool isDarkModeBtnVisible;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: (isDark
                    ? const Color(0xFF0A0E1A)
                    : const Color(0xFFF5F7FF))
                .withOpacity(0.7),
            border: Border(
              bottom: BorderSide(
                color: (isDark
                        ? const Color(0xFF00E5FF)
                        : const Color(0xFF6C63FF))
                    .withOpacity(0.15),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavLogo(),
              ..._buildButtons(context),
              if (isDarkModeBtnVisible) const ThemeButton(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    return [
      UnderlinedButton(context: context, tabNumber: 0, btnNumber: '00.', btnName: 'Home'),
      UnderlinedButton(context: context, tabNumber: 1, btnNumber: '01.', btnName: 'What I Do'),
      UnderlinedButton(context: context, tabNumber: 2, btnNumber: '02.', btnName: 'Education'),
      UnderlinedButton(context: context, tabNumber: 3, btnNumber: '03.', btnName: 'Experience'),
      UnderlinedButton(context: context, tabNumber: 4, btnNumber: '04.', btnName: 'Projects'),
      UnderlinedButton(context: context, tabNumber: 5, btnNumber: '05.', btnName: 'Achievements'),
      UnderlinedButton(context: context, tabNumber: 6, btnNumber: '06.', btnName: 'Contact Me'),
    ];
  }
}

class _NavLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584)];

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: gradient,
      ).createShader(bounds),
      child: Text(
        '<JJ />',
        style: TextStyle(
          fontFamily: 'SourceCodePro',
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 3,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
  }) : super(key: key);

  final double height, width;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584)];

    return Container(
      padding: EdgeInsets.only(bottom: height * 0.02, top: height * 0.02),
      width: width * 0.9,
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: gradient,
            ).createShader(bounds),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'SourceCodePro',
                letterSpacing: 8,
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradient[0].withOpacity(0.5),
                    gradient[0].withOpacity(0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

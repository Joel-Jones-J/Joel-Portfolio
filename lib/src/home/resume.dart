import 'package:flutter/material.dart';

import '../html_open_link.dart';
import 'data.dart';

class Resume extends StatelessWidget {
  Resume({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;
  final String data = resume();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584)];

    if (data == '') return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(right: width * 0.019),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: gradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds),
        child: TextButton.icon(
          onPressed: () => htmlOpenLink(data),
          icon: const Icon(Icons.download_rounded, size: 20, color: Colors.white),
          label: const Text(
            'RESUME',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            backgroundColor: const Color(0xFF1A1F35).withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isDark
                    ? const Color(0xFF00E5FF).withOpacity(0.3)
                    : const Color(0xFF6C63FF).withOpacity(0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

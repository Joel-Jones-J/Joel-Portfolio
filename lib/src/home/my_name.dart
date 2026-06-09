import 'package:flutter/material.dart';
import 'data.dart';

class MyName extends StatelessWidget {
  MyName({
    Key? key,
    required this.isMobile,
    required this.context,
  }) : super(key: key);

  final bool isMobile;
  final BuildContext context;
  final String data = name();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF), Color(0xFFFF4081)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584), Color(0xFFFFB347)];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(data.split(' ').length, (int i) {
                  return SizedBox(
                    width: width - width * 0.4,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        data.split(' ')[i],
                        textScaler: const TextScaler.linear(4.5),
                        style: const TextStyle(
                          fontFamily: 'FjallaOne',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              )
            : Text(
                data,
                textScaler: const TextScaler.linear(7),
                style: const TextStyle(
                  fontFamily: 'FjallaOne',
                  letterSpacing: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

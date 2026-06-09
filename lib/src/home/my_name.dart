import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'data.dart';

class MyName extends StatefulWidget {
  MyName({
    Key? key,
    required this.isMobile,
    required this.context,
  }) : super(key: key);

  final bool isMobile;
  final BuildContext context;

  @override
  State<MyName> createState() => _MyNameState();
}

class _MyNameState extends State<MyName> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final String data = name();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF), Color(0xFFFF4081), Color(0xFF00E5FF)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584), Color(0xFFFFB347), Color(0xFF6C63FF)];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final angle = _controller.value * 2 * math.pi;
        final dx = math.sin(angle);
        final dy = math.cos(angle);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: colors,
              begin: Alignment(-dx, -dy),
              end: Alignment(dx, dy),
              stops: const [0.0, 0.35, 0.7, 1.0],
            ).createShader(bounds),
            child: widget.isMobile
                ? _buildMobile(width)
                : _buildDesktop(),
          ),
        );
      },
    );
  }

  Widget _buildMobile(double width) {
    return Column(
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
    );
  }

  Widget _buildDesktop() {
    return Text(
      data,
      textScaler: const TextScaler.linear(7),
      style: const TextStyle(
        fontFamily: 'FjallaOne',
        letterSpacing: 12,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

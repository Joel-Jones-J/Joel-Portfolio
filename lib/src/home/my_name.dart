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
  late AnimationController _gradientController;
  late Animation<double> _gradientAnim;
  final String data = name();

  @override
  void initState() {
    super.initState();
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _gradientAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _gradientController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF), Color(0xFFFF4081)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584), Color(0xFFFFB347)];

    return AnimatedBuilder(
      animation: _gradientController,
      builder: (context, _) {
        final t = _gradientAnim.value;
        final begin = Alignment.lerp(
          Alignment.topLeft,
          Alignment.bottomRight,
          t,
        )!;
        final end = Alignment.lerp(
          Alignment.bottomRight,
          Alignment.topLeft,
          t,
        )!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: colors,
              begin: begin,
              end: end,
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

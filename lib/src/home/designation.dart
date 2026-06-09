import 'dart:async';
import 'package:flutter/material.dart';

import '../custom/custom_text.dart';
import 'data.dart';

class Designation extends StatelessWidget {
  Designation({
    Key? key,
    required this.isMobile,
    required this.context,
  }) : super(key: key);

  final bool isMobile;
  final BuildContext context;
  final List<String> data = designation();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.auto_awesome,
          color: Theme.of(context).primaryColor,
          size: isMobile ? 28 : 36,
        ),
        const SizedBox(width: 8),
        TextSwapController(
          data: data,
          isMobile: isMobile,
        ),
      ],
    );
  }
}

class TextSwapController extends StatefulWidget {
  const TextSwapController({
    Key? key,
    required this.data,
    required this.isMobile,
  }) : super(key: key);

  final List<String> data;
  final bool isMobile;

  @override
  _TextSwapControllerState createState() => _TextSwapControllerState();
}

class _TextSwapControllerState extends State<TextSwapController>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late Timer _timer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _fadeController.forward();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;
      _fadeController.reverse().then((_) {
        if (!mounted) return;
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.data.length;
        });
        _fadeController.forward();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584)];

    return FadeTransition(
      opacity: _fadeAnim,
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: CustomText(
          text: widget.data[_currentIndex],
          isTextAlignCenter: false,
          fontSize: widget.isMobile ? 40 : 56,
          color: Colors.white,
          weight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

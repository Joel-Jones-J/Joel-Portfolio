import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../src/home/about.dart';
import '../src/home/data.dart';
import '../src/home/designation.dart';
import '../src/home/introduction.dart';
import '../src/home/my_name.dart';
import '../src/home/resume.dart';
import '../src/home/social_media_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<Offset> _bgAnim;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        SystemChrome.setApplicationSwitcherDescription(
          ApplicationSwitcherDescription(
            label: 'Meet ${name().split(' ').first}',
            primaryColor: Colors.black.value,
          ),
        );
      });
    });

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _bgAnim = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.05, 0.05),
    ).animate(_bgController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.1),
      child: SizedBox(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth < 1000;
            return Stack(
              children: [
                AnimatedBuilder(
                  animation: _bgController,
                  builder: (context, _) {
                    return Positioned.fill(
                      child: CustomPaint(
                        painter: _BgGradientPainter(
                          offset: _bgAnim.value,
                          isDark: isDark,
                        ),
                      ),
                    );
                  },
                ),
                if (mobile) _buildMobile(width, height) else _buildDesktop(width, height),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMobile(double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.024),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.07),
            child: const Introduction(word: 'Hello,\nI am', textScaleFactor: 3),
          ),
          MyName(isMobile: true, context: context),
          Designation(isMobile: true, context: context),
          SocialMediaBar(height: height),
          About(fontSize: 22),
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.029),
            child: Resume(width: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.08, bottom: height * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.032),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Introduction(word: 'Hello, I am', textScaleFactor: 3.5),
                FittedBox(
                  fit: BoxFit.cover,
                  child: MyName(isMobile: false, context: context),
                ),
                Designation(isMobile: false, context: context),
                SocialMediaBar(height: height),
                About(fontSize: 28),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.026),
                  child: Resume(width: width),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BgGradientPainter extends CustomPainter {
  final Offset offset;
  final bool isDark;

  _BgGradientPainter({required this.offset, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(offset.dx * size.width, offset.dy * size.height) & size;
    final gradient = RadialGradient(
      colors: isDark
          ? [
              const Color(0xFF0A0E1A),
              const Color(0xFF0F1525),
              const Color(0xFF1A0A2E),
            ]
          : [
              const Color(0xFFF5F7FF),
              const Color(0xFFF0F0FF),
              const Color(0xFFFFF5F8),
            ],
      radius: 1.2,
      focal: const Alignment(-0.3, -0.2),
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _BgGradientPainter old) =>
      old.offset != offset || old.isDark != isDark;
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'src/nav_bar/nav_bar.dart';
import 'src/theme/theme_button.dart';
import 'tabs/tabs.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  bool _showMobileWarning = true;
  late AnimationController _bgController;
  late Animation<Offset> _bgAnim;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkMobileAndShowWarning();
    });
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
    _bgAnim = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.03, 0.03),
    ).animate(_bgController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  void _checkMobileAndShowWarning() {
    final width = MediaQuery.of(context).size.width;
    if (width < 600 && _showMobileWarning) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _showMobileWarningDialog();
      });
    }
  }

  void _showMobileWarningDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return const _MobileWarningDialog();
      },
    ).then((_) {
      if (mounted) setState(() => _showMobileWarning = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(builder: (context, constraints) {
      Widget scaffold;
      if (constraints.maxWidth < 1000) {
        scaffold = Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            child: const ThemeButton(),
          ),
          body: ScrollablePositionedList.builder(
            physics: const BouncingScrollPhysics(),
            minCacheExtent: double.infinity,
            shrinkWrap: true,
            itemCount: 7,
            itemScrollController: scroll,
            itemBuilder: (ctx, index) => widgetList[index],
          ),
        );
      } else {
        scaffold = Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size(width, height * 0.07),
            child: const NavBar(isDarkModeBtnVisible: true),
          ),
          body: ScrollablePositionedList.builder(
            physics: const BouncingScrollPhysics(),
            minCacheExtent: double.infinity,
            shrinkWrap: true,
            itemCount: 7,
            itemScrollController: scroll,
            itemBuilder: (ctx, index) => widgetList[index],
          ),
        );
      }

      return Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bgController,
              builder: (ctx, _) => CustomPaint(
                painter: _AppBgPainter(
                  offset: _bgAnim.value,
                  isDark: isDark,
                ),
              ),
            ),
          ),
          scaffold,
        ],
      );
    });
  }
}

class _AppBgPainter extends CustomPainter {
  final Offset offset;
  final bool isDark;

  _AppBgPainter({required this.offset, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(offset.dx * size.width, offset.dy * size.height) & size;
    final gradient = RadialGradient(
      colors: isDark
          ? [
              const Color(0xFF0A0E1A),
              const Color(0xFF0D1320),
              const Color(0xFF150A25),
            ]
          : [
              const Color(0xFFF5F7FF),
              const Color(0xFFF0F0FF),
              const Color(0xFFFFF5F8),
            ],
      radius: 1.3,
      focal: const Alignment(-0.2, -0.3),
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _AppBgPainter old) =>
      old.offset != offset || old.isDark != isDark;
}

class _MobileWarningDialog extends StatelessWidget {
  const _MobileWarningDialog();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);
    final bgColor = isDark
        ? const Color(0xFF141829).withOpacity(0.95)
        : const Color(0xFFFFFFFF).withOpacity(0.97);
    final gradient = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584)];

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 380),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: bgColor,
                border: Border.all(
                  color: accent.withOpacity(0.15),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.15),
                    blurRadius: 40,
                    spreadRadius: 2,
                    offset: const Offset(0, 16),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.5 : 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: gradient[0].withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.desktop_windows_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Desktop Recommended',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                        color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 36,
                      height: 3.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: LinearGradient(colors: gradient),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'For the best experience, please visit this portfolio on a desktop or laptop.',
                      style: TextStyle(
                        fontSize: 14.5,
                        height: 1.6,
                        color: isDark
                            ? Colors.white.withOpacity(0.6)
                            : const Color(0xFF1A1A2E).withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: accent.withOpacity(0.07),
                        border: Border.all(
                          color: accent.withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 15,
                            color: accent,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Optimized for screens wider than 600px.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: accent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(colors: gradient),
                          boxShadow: [
                            BoxShadow(
                              color: gradient[0].withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Got it, thanks!',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

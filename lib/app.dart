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

class _AppState extends State<App> {
  bool _showMobileWarning = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkMobileAndShowWarning();
    });
  }

  void _checkMobileAndShowWarning() {
    final width = MediaQuery.of(context).size.width;
    if (width < 600 && _showMobileWarning) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _showMobileWarningDialog();
        }
      });
    }
  }

  void _showMobileWarningDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(curved),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return const _MobileWarningDialog();
      },
    ).then((_) {
      setState(() {
        _showMobileWarning = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1000) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: const ThemeButton(),
          ),
          body: ScrollablePositionedList.builder(
              physics: const BouncingScrollPhysics(),
              minCacheExtent: double.infinity,
              shrinkWrap: true,
              itemCount: 7,
              itemScrollController: scroll,
              itemBuilder: (context, index) {
                return widgetList[index];
              }),
        );
      } else {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(width, height * 0.07),
              child: const NavBar(isDarkModeBtnVisible: true)),
          body: ScrollablePositionedList.builder(
              physics: const BouncingScrollPhysics(),
              minCacheExtent: double.infinity,
              shrinkWrap: true,
              itemCount: 7,
              itemScrollController: scroll,
              itemBuilder: (context, index) {
                return widgetList[index];
              }),
        );
      }
    });
  }
}

class _MobileWarningDialog extends StatelessWidget {
  const _MobileWarningDialog();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 380),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: isDark
                  ? Colors.grey.shade900.withOpacity(0.95)
                  : Colors.white.withOpacity(0.97),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.06),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.15),
                  blurRadius: 40,
                  spreadRadius: 0,
                  offset: const Offset(0, 16),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.5 : 0.12),
                  blurRadius: 24,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon badge
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary,
                          colorScheme.primary.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.35),
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

                  // Title
                  Text(
                    'Desktop Recommended',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Divider accent
                  Container(
                    width: 36,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Body text
                  Text(
                    'For the best experience, please visit this portfolio on a desktop or laptop.',
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.6,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtle secondary note
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colorScheme.primary.withOpacity(0.07),
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 15,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Optimized for screens wider than 600px.',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // CTA Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
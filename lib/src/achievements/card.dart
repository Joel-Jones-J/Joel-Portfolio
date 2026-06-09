import 'dart:ui';
import 'package:flutter/material.dart';

import '../custom/custom_text.dart';
import '../html_open_link.dart';

class AchievementsCard extends StatefulWidget {
  const AchievementsCard({
    Key? key,
    required this.desc,
    required this.isMobile,
    required this.link,
  }) : super(key: key);

  final String desc, link;
  final bool isMobile;
  @override
  _AchievementsCardState createState() => _AchievementsCardState();
}

class _AchievementsCardState extends State<AchievementsCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);
    final bgColor = isDark
        ? const Color(0xFF141829)
        : const Color(0xFFFFFFFF);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      transform: _hover
          ? (Matrix4.identity()..translate(0, -6))
          : Matrix4.identity(),
      child: InkWell(
        onHover: (v) => setState(() => _hover = v),
        onTap: () => htmlOpenLink(widget.link),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            vertical: height * 0.035,
            horizontal: width * 0.025,
          ),
          width: widget.isMobile ? width : width * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: _hover
                  ? [bgColor, accent.withOpacity(0.05)]
                  : [bgColor, bgColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: _hover
                  ? accent.withOpacity(0.3)
                  : accent.withOpacity(0.06),
              width: 1.5,
            ),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: accent.withOpacity(0.15),
                      blurRadius: 24,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _hover ? 4 : 0, sigmaY: _hover ? 4 : 0),
              child: Column(
                children: [
                  Icon(
                    Icons.emoji_events_rounded,
                    size: 36,
                    color: accent,
                  ),
                  const SizedBox(height: 12),
                  CustomText(
                    text: widget.desc,
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.9),
                    weight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                  if (_hover) ...[
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: accent.withOpacity(0.15),
                      ),
                      child: Text(
                        'View Details →',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

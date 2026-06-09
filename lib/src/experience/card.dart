import 'dart:ui';
import 'package:flutter/material.dart';

import '../custom/custom_text.dart';

class ExperienceCard extends StatefulWidget {
  const ExperienceCard({
    Key? key,
    required this.image,
    required this.title,
    required this.desc,
    required this.period,
    required this.role,
    required this.isMobile,
  }) : super(key: key);

  final String image, title, desc, period, role;
  final bool isMobile;

  @override
  _ExperienceCardState createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
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
          ? (Matrix4.identity()..translate(0, -8))
          : Matrix4.identity(),
      width: widget.isMobile ? width : width * 0.3,
      child: InkWell(
        onHover: (v) => setState(() => _hover = v),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
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
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
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
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _hover ? 6 : 0, sigmaY: _hover ? 6 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(
                        'assets/experience/${widget.image}',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(width * 0.018),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: widget.title,
                          fontSize: 20,
                          color: Colors.white,
                          weight: FontWeight.w700,
                          isTextAlignCenter: false,
                          letterSpacing: 0,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: accent.withOpacity(0.12),
                          ),
                          child: Text(
                            widget.role,
                            style: TextStyle(
                              fontFamily: 'SourceCodePro',
                              fontSize: 12,
                              color: accent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 14, color: accent.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Text(
                              widget.period,
                              style: TextStyle(
                                fontFamily: 'SourceCodePro',
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.desc,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.5,
                          ),
                        ),
                      ],
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

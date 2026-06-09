import 'dart:ui';
import 'package:flutter/material.dart';

import '../custom/custom_text.dart';

class EducationDesktop extends StatefulWidget {
  const EducationDesktop({
    Key? key,
    required this.instiution,
    required this.location,
    required this.desc,
    required this.grades,
    required this.years,
    required this.image,
  }) : super(key: key);

  final String instiution, location, years, grades, desc, image;
  @override
  _EducationDesktopState createState() => _EducationDesktopState();
}

class _EducationDesktopState extends State<EducationDesktop> {
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
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            vertical: height * 0.025,
            horizontal: width * 0.025,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: _hover
                  ? [
                      bgColor,
                      accent.withOpacity(0.05),
                    ]
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
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _hover ? 4 : 0, sigmaY: _hover ? 4 : 0),
              child: Column(
                children: [
                  if (width < 1000)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildImage(50, 50),
                    ),
                  Row(
                    children: [
                      if (width >= 1000)
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: _buildImage(90, 90),
                        ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: widget.instiution,
                              fontSize: 20,
                              color: Colors.white,
                              weight: FontWeight.w700,
                              isTextAlignCenter: false,
                              letterSpacing: 0,
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              text: widget.location,
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.6),
                              isTextAlignCenter: false,
                              letterSpacing: 0,
                            ),
                            if (widget.years != '') ...[
                              const SizedBox(height: 6),
                              _TagChip(text: widget.years, label: 'Years'),
                            ],
                            const SizedBox(height: 10),
                            CustomText(
                              text: widget.desc,
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.85),
                              isTextAlignCenter: false,
                              weight: FontWeight.w400,
                              letterSpacing: 0,
                            ),
                            if (widget.grades != '') ...[
                              const SizedBox(height: 8),
                              _TagChip(text: widget.grades, label: 'Grade'),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(double w, double h) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/education/${widget.image}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text, label;
  const _TagChip({Key? key, required this.text, required this.label});

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: accent.withOpacity(0.12),
        border: Border.all(
          color: accent.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        '$label: $text',
        style: TextStyle(
          fontFamily: 'SourceCodePro',
          fontSize: 11,
          color: accent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

import '../custom/custom_text.dart';
import '../html_open_link.dart';
import 'data.dart';

class ProjectsCard extends StatefulWidget {
  const ProjectsCard({
    Key? key,
    required this.title,
    required this.techStack,
    required this.desc,
    required this.link,
    required this.isMobile,
  }) : super(key: key);

  final String title, techStack, desc, link;
  final bool isMobile;
  @override
  _ProjectsCardState createState() => _ProjectsCardState();
}

class _ProjectsCardState extends State<ProjectsCard> {
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
          ? (Matrix4.identity()..translate(0, -8))
          : Matrix4.identity(),
      width: widget.isMobile ? width : width * 0.3,
      child: InkWell(
        onHover: (v) => setState(() => _hover = v),
        onTap: () => htmlOpenLink(widget.link),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            vertical: height * 0.025,
            horizontal: width * 0.02,
          ),
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
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _hover ? 4 : 0, sigmaY: _hover ? 4 : 0),
              child: _buildContent(width),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(double width) {
    if (widget.title == '' && widget.link != '') {
      return FutureBuilder(
        future: github(widget.link),
        builder: (context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<String>;
            return _cardBody(data[0], data[1], data[2], data.length > 3 ? data[3] : '', data.length > 4 ? data[4] : '');
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
    return _cardBody(widget.title, widget.techStack, widget.desc, '', '');
  }

  Widget _cardBody(String title, String techStack, String desc, String stars, String forks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code_rounded, size: 20, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 18,
                color: Colors.white,
                weight: FontWeight.w700,
                isTextAlignCenter: false,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomText(
          text: desc,
          fontSize: 13,
          color: Colors.white.withOpacity(0.75),
          isTextAlignCenter: false,
          weight: FontWeight.w400,
          letterSpacing: 0,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF00E5FF).withOpacity(0.1)
                : const Color(0xFF6C63FF).withOpacity(0.1),
          ),
          child: Text(
            techStack,
            style: TextStyle(
              fontFamily: 'SourceCodePro',
              fontSize: 11,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (stars != '' || forks != '') ...[
          const SizedBox(height: 10),
          Row(
            children: [
              if (stars != '')
                _StatChip(icon: Icons.star_rounded, value: stars),
              if (forks != '') ...[
                const SizedBox(width: 12),
                _StatChip(icon: Icons.call_split_rounded, value: forks),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  const _StatChip({Key? key, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white.withOpacity(0.5)),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'SourceCodePro',
            fontSize: 12,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../html_open_link.dart';
import 'data.dart';

class SocialMediaBar extends StatelessWidget {
  SocialMediaBar({Key? key, required this.height}) : super(key: key);
  final List<List<String>> data = socialMedia();
  final double height;

  @override
  Widget build(BuildContext context) {
    final List<String> supported = [
      'email', 'facebook', 'github', 'instagram', 'linkedin',
      'medium', 'stackoverflow', 'twitter', 'leetcode'
    ];
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Row(
          children: List.generate(data.length, (int i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _GlowIconButton(
                link: data[i][0],
                image: supported.contains(data[i][1])
                    ? 'assets/home/constant/${data[i][1]}.png'
                    : 'assets/home/constant/link.png',
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _GlowIconButton extends StatefulWidget {
  const _GlowIconButton({Key? key, required this.link, required this.image});
  final String link, image;

  @override
  __GlowIconButtonState createState() => __GlowIconButtonState();
}

class __GlowIconButtonState extends State<_GlowIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glowColor = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => htmlOpenLink(widget.link),
      onHover: (v) => setState(() => _hover = v),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.all(_hover ? 10 : 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _hover ? glowColor.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: _hover ? glowColor.withOpacity(0.3) : Colors.transparent,
            width: 1,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: glowColor.withOpacity(0.25),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Image.asset(
          widget.image,
          scale: _hover ? 1 : 1.1,
        ),
      ),
    );
  }
}

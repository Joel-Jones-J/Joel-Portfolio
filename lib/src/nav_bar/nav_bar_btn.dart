import 'package:flutter/material.dart';

import '../../tabs/tabs.dart';

class UnderlinedButton extends StatefulWidget {
  const UnderlinedButton({
    Key? key,
    required this.context,
    required this.btnName,
    required this.btnNumber,
    required this.tabNumber,
  }) : super(key: key);

  @override
  _UnderlinedButtonState createState() => _UnderlinedButtonState();

  final BuildContext context;
  final String btnName, btnNumber;
  final int tabNumber;
}

class _UnderlinedButtonState extends State<UnderlinedButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);
    final textColor = isDark ? const Color(0xFFEEF0FF) : const Color(0xFF1A1A2E);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      hoverColor: Colors.transparent,
      onTap: () => scroll.scrollTo(
        index: widget.tabNumber,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic,
      ),
      onHover: (v) => setState(() => _isHover = v),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: _isHover ? 6 : 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _isHover ? accentColor.withOpacity(0.08) : Colors.transparent,
          border: Border.all(
            color: _isHover ? accentColor.withOpacity(0.3) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SourceCodePro',
                color: _isHover ? accentColor : textColor.withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
              child: Text(widget.btnNumber),
            ),
            const SizedBox(width: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: _isHover ? accentColor : textColor,
                fontWeight: _isHover ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.5,
              ),
              child: Text(widget.btnName),
            ),
          ],
        ),
      ),
    );
  }
}

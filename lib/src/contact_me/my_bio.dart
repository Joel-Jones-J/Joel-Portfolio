import 'package:flutter/material.dart';
import 'data.dart';

class MyBio extends StatelessWidget {
  MyBio({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  final double fontSize;
  final String getBio = bio();

  @override
  Widget build(BuildContext context) {
    if (getBio == '') return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF00E5FF).withOpacity(0.05)
              : const Color(0xFF6C63FF).withOpacity(0.05),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF00E5FF).withOpacity(0.1)
                : const Color(0xFF6C63FF).withOpacity(0.1),
          ),
        ),
        child: Text(
          '"$getBio"',
          style: TextStyle(
            fontFamily: 'SourceCodePro',
            letterSpacing: 1.5,
            color: Theme.of(context).primaryColorLight.withOpacity(0.7),
            fontSize: fontSize,
            height: 1.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

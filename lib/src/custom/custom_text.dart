import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    required this.fontSize,
    this.isTextAlignCenter = true,
    this.color,
    this.weight,
    this.letterSpacing,
    this.height,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double fontSize;
  final bool isTextAlignCenter;
  final FontWeight? weight;
  final double? letterSpacing;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: isTextAlignCenter ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontFamily: 'Montserrat',
        letterSpacing: letterSpacing ?? 1,
        fontSize: fontSize,
        color: color ?? Theme.of(context).primaryColorLight,
        fontWeight: weight ?? FontWeight.w500,
        height: height,
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText({
    Key? key,
    required this.text,
    required this.gradient,
    this.fontSize,
    this.fontFamily,
    this.letterSpacing,
    this.fontWeight,
  }) : super(key: key);

  final String text;
  final List<Color> gradient;
  final double? fontSize;
  final String? fontFamily;
  final double? letterSpacing;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight,
          color: Colors.white,
        ),
      ),
    );
  }
}

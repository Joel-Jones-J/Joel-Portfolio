import 'package:flutter/material.dart';

class Progress extends StatefulWidget {
  const Progress({
    Key? key,
    required this.width,
    required this.widthSecondContainer,
    required this.title,
    required this.sizeProficiencyName,
    required this.sizePercentage,
  }) : super(key: key);
  @override
  _ProgressState createState() => _ProgressState();

  final double width, widthSecondContainer, sizeProficiencyName, sizePercentage;
  final String title;
}

class _ProgressState extends State<Progress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      upperBound: widget.widthSecondContainer / 100,
    );
    _controller.addListener(() => setState(() {}));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _controller.value * 100;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? const [Color(0xFF00E5FF), Color(0xFFB388FF), Color(0xFFFF4081)]
        : const [Color(0xFF6C63FF), Color(0xFFFF6584)];
    final accent = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);

    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: widget.sizeProficiencyName,
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: accent.withOpacity(0.12),
                ),
                child: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontFamily: 'SourceCodePro',
                    fontSize: widget.sizePercentage,
                    color: accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: widget.width / 1.2,
            height: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDark
                          ? const Color(0xFF1A1F35)
                          : const Color(0xFFEEF0FF),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: _controller.value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: gradientColors[0].withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

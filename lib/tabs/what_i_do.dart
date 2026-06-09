import 'package:flutter/material.dart';

import '../src/custom/custom_text.dart';
import '../src/nav_bar/title_bar.dart';
import '../src/whatIDo/data.dart';
import '../src/whatIDo/progress.dart';

class WhatIdo extends StatelessWidget {
  WhatIdo({Key? key}) : super(key: key);

  final List<List<String>> data = whatIdo();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        TitleBar(height: height, width: width, title: 'WHAT I DO'),
        Padding(
          padding: EdgeInsets.only(bottom: height * 0.1),
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              if (constraints.maxWidth < 1000) {
                return _buildMobile(ctx, height, width);
              }
              return _buildDesktop(ctx, height, width);
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildMobile(BuildContext ctx, double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(text: '⚡ I have a good proficiency in:'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/what_i_do/constant/checklist.png',
                scale: 2,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: List.generate(
                    data[0].length,
                    (i) => Progress(
                      width: width / 1.55,
                      widthSecondContainer: double.parse(data[0][i].split('--')[1]),
                      title: data[0][i].split('--')[0],
                      sizeProficiencyName: 12,
                      sizePercentage: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (data[1].isNotEmpty) ...[
          _SectionHeader(text: '⚡ Some languages & tools I use:'),
          _ToolGrid(data: data[1], columns: 4),
        ],
      ],
    );
  }

  Widget _buildDesktop(BuildContext ctx, double height, double width) {
    final theme = Theme.of(ctx);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(70, 10, 70, 20),
          child: CustomText(
            text: '⚡ I have a good proficiency in:',
            fontSize: 35,
            color: theme.primaryColorLight,
            isTextAlignCenter: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width / 2.2,
                child: Column(
                  children: List.generate(
                    data[0].length,
                    (i) => Progress(
                      width: width / 2,
                      widthSecondContainer: double.parse(data[0][i].split('--')[1]),
                      title: data[0][i].split('--')[0],
                      sizeProficiencyName: 20,
                      sizePercentage: 14,
                    ),
                  ),
                ),
              ),
              Image.asset(
                'assets/what_i_do/constant/checklist.png',
                scale: 1.5,
              ),
            ],
          ),
        ),
        if (data[1].isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 30, 70, 20),
            child: CustomText(
              text: '⚡ Some languages & tools I use:',
              fontSize: 35,
              color: theme.primaryColorLight,
              isTextAlignCenter: false,
            ),
          ),
          _ToolGrid(data: data[1], columns: 8),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader({Key? key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 24, 15, 16),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          color: Theme.of(context).primaryColorLight,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ToolGrid extends StatefulWidget {
  final List<String> data;
  final int columns;
  const _ToolGrid({Key? key, required this.data, required this.columns});

  @override
  __ToolGridState createState() => __ToolGridState();
}

class __ToolGridState extends State<_ToolGrid> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final rows = (widget.data.length / widget.columns).ceil();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: List.generate(rows, (i) {
          final start = i * widget.columns;
          final count = (widget.data.length - start).clamp(0, widget.columns);
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(count, (j) {
                final index = start + j;
                final isHover = _hoveredIndex == index;
                return InkWell(
                  onHover: (v) => setState(() => _hoveredIndex = v ? index : null),
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.all(isHover ? 18 : 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isHover
                          ? Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF00E5FF).withOpacity(0.08)
                              : const Color(0xFF6C63FF).withOpacity(0.08)
                          : Colors.transparent,
                      border: Border.all(
                        color: isHover
                            ? Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF00E5FF).withOpacity(0.2)
                                : const Color(0xFF6C63FF).withOpacity(0.2)
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Image.asset(
                      'assets/what_i_do/${widget.data[index]}',
                      scale: isHover ? 1 : 1.15,
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

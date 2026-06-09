import 'dart:ui';
import 'package:flutter/material.dart';

import '../src/contact_me/data.dart';
import '../src/contact_me/my_bio.dart';
import '../src/custom/custom_text.dart';
import '../src/home/social_media_bar.dart';
import '../src/html_open_link.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  final List<String> data = contactMe();
  final List<String> getNameAndLink = nameAndLink();
  bool _imageHover = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);
    final cardBg = isDark
        ? const Color(0xFF141829).withOpacity(0.6)
        : const Color(0xFFFFFFFF).withOpacity(0.8);

    Widget imageWidget(double scale) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: _imageHover
            ? (Matrix4.identity()..translate(0, -4))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: _imageHover
              ? [
                  BoxShadow(
                    color: accent.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: accent.withOpacity(0.12),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: InkWell(
          onTap: () {},
          onHover: (v) => setState(() => _imageHover = v),
          hoverColor: Colors.transparent,
          borderRadius: BorderRadius.circular(200),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: accent.withOpacity(_imageHover ? 0.5 : 0.2),
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: scale * 30,
              backgroundImage: AssetImage(
                data[2] != ''
                    ? 'assets/contact_me/${data[2]}'
                    : 'assets/contact_me/constant/picture.png',
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 1000) {
                return _buildMobile(width, height, isDark, accent, cardBg, imageWidget);
              }
              return _buildDesktop(width, height, isDark, accent, cardBg, imageWidget);
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => htmlOpenLink(getNameAndLink[1]),
            child: Text(
              'Made with ❤️ by ${getNameAndLink[0]}',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(double width, double height, bool isDark, Color accent, Color cardBg, Widget Function(double) imageWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: cardBg,
              border: Border.all(
                color: accent.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                CustomText(
                  text: 'Reach Out to me!',
                  fontSize: 26,
                  color: Theme.of(context).primaryColorLight,
                  weight: FontWeight.w700,
                  letterSpacing: 0,
                ),
                const SizedBox(height: 16),
                imageWidget(2.7),
                const SizedBox(height: 16),
                CustomText(
                  text: 'DISCUSS A PROJECT OR JUST WANT TO SAY HI? MY INBOX IS OPEN FOR ALL.',
                  fontSize: 14,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.6),
                  letterSpacing: 0,
                ),
                MyBio(fontSize: 14),
                const SizedBox(height: 8),
                if (data[0] != '')
                  _InfoRow(icon: Icons.location_on_rounded, text: data[0]),
                const SizedBox(height: 6),
                if (data[1] != '')
                  _InfoRow(icon: Icons.wifi_tethering_rounded, text: 'Open for opportunities: ${data[1]}'),
                const SizedBox(height: 16),
                SocialMediaBar(height: height),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop(double width, double height, bool isDark, Color accent, Color cardBg, Widget Function(double) imageWidget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 48),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: cardBg,
              border: Border.all(
                color: accent.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: accent.withOpacity(0.06),
                  blurRadius: 40,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Reach Out to me!',
                        fontSize: 32,
                        color: Theme.of(context).primaryColorLight,
                        weight: FontWeight.w700,
                        isTextAlignCenter: false,
                        letterSpacing: -0.5,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: 'DISCUSS A PROJECT OR JUST WANT TO SAY HI? MY INBOX IS OPEN FOR ALL.',
                        fontSize: 15,
                        color: Theme.of(context).primaryColorLight.withOpacity(0.6),
                        isTextAlignCenter: false,
                        letterSpacing: 0,
                      ),
                      MyBio(fontSize: 14),
                      const SizedBox(height: 12),
                      if (data[0] != '')
                        _InfoRow(icon: Icons.location_on_rounded, text: data[0]),
                      const SizedBox(height: 8),
                      if (data[1] != '')
                        _InfoRow(icon: Icons.wifi_tethering_rounded, text: 'Open for opportunities: ${data[1]}'),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      imageWidget(2.5),
                      const SizedBox(height: 20),
                      SocialMediaBar(height: height),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({Key? key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF6C63FF);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: accent),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15,
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

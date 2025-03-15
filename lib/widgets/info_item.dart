import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

class InfoItem extends StatelessWidget {
  final String icon;
  final String value;

  const InfoItem({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: StaticColors.platinum,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: 16,
              width: 16,
              child: SvgPicture.asset(icon),
            ),
          ),
        ),
        const SizedBox(width: 8, height: 8),
        Text(
          value,
          style: GoogleFonts.roboto(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

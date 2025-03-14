import 'package:flutter/material.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/screen_size.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSize.of(context);
    final width = screenSize.width;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StaticText.popularPlaces,
            style: GoogleFonts.roboto(
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
              onTap: () {},
              child: Text(
                StaticText.viewAll,
                style: GoogleFonts.roboto(
                  fontSize: width * 0.035,
                  color: Colors.blueAccent,
                ),
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/screen_size.dart';

class HomeScreenHeader extends StatelessWidget {
  String name;

  String image;

  HomeScreenHeader({super.key,
    this.name = StaticText.hiDavid,
    this.image = 'assets/images/profile_pic.png'});

  @override
  Widget build(BuildContext context) {

    final screenSize = ScreenSize.of(context);
    final width = screenSize.width;
    final height = screenSize.height;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: name,
                        style: GoogleFonts.montserrat(
                          fontSize: width * 0.07, // Responsive font size
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(
                        child: Text(' 👋',
                            style: TextStyle(fontSize: width * 0.06)),
                      ),
                    ],
                  ),
                ),
               SizedBox(height: height * 0.007),
               Text(StaticText.exploreTheWorld,style: GoogleFonts.inter(
                 fontSize: width * 0.045,
                 color: StaticColors.mediumGray,
                 fontWeight: FontWeight.w500
               ),)
             ],
           ),
          CircleAvatar(
            radius: width * 0.06, // Responsive radius
            backgroundImage:
            AssetImage(image),
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

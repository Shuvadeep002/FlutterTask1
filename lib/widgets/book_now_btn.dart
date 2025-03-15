import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class BookNowBtn extends StatelessWidget {
  const BookNowBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StaticText.bookNow,
              style: GoogleFonts.roboto(
                  color: Colors.white, fontSize: 16),
            ),
            SizedBox(width: 18),
            SizedBox(
              height: 16,
              width: 16,
              child: SvgPicture.asset("assets/icons/send_icon.svg"),),
          ],
        ),
      ),
    );
  }
}

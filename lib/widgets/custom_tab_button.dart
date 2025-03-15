import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onPressed;

  const CustomTabButton({
    super.key,
    required this.title,
    this.isActive = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.roboto(
          color: isActive ? Colors.black : Colors.grey,
          fontSize: isActive ? 21 : 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

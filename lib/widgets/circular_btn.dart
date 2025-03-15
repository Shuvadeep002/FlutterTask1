import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const CircularButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        padding: const EdgeInsets.all(13),
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

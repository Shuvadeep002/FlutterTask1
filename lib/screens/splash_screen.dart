import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task/navigation/route_info.dart';
import 'package:flutter_task/utils/screen_size.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Single controller for both forward and reverse animations
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _positionAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startAnimation();
  }

  void _startAnimation() async {
    // Forward animation
    await _controller.forward();

    // Hold for 0.5 seconds
    await Future.delayed(const Duration(milliseconds: 500));

    // Reverse animation
    await _controller.reverse();

    // Navigate to home screen
    if (mounted) context.go(AppRoutePath.MainRoutePath);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: StaticColors.cornflowerBlue, // Set to transparent or any color
        statusBarIconBrightness: Brightness.dark, // For dark icons on light background
      ),
    );
    final screenSize = ScreenSize.of(context);
    final width = screenSize.width;
    final height = screenSize.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Travel Text with opacity animation
                      Opacity(
                        opacity: _opacityAnimation.value,
                        child: Text(
                          StaticText.travel,
                          style: GoogleFonts.lobster(
                            fontSize: width * 0.1,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.02),

                      // Globe icon with position animation
                      Transform.translate(
                        offset: Offset(_positionAnimation.value, 0),
                        child: SvgPicture.asset(
                          'assets/icons/globe_icon.svg',
                          width: width * 0.07,
                          height: width * 0.07,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: height * 0.03),

              Text(
                '${StaticText.findYouDream}\n${StaticText.designationWithUs}',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: width * 0.045,
                  color: Colors.white70,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

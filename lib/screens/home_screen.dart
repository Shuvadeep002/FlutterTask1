import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task/widgets/home_searchbar.dart';
import '../utils/screen_size.dart';
import '../widgets/header_component.dart';
import '../widgets/home_filter.dart';
import '../widgets/home_screen_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Set to transparent or any color
        statusBarIconBrightness: Brightness.dark, // For dark icons on light background
      ),
    );
    final screenSize = ScreenSize.of(context);
    final width = screenSize.width;
    final height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar Section
              HomeScreenHeader(),
              SizedBox(height: height * 0.01),
              HomeSearchbar(),
              // Search Bar Section
              SizedBox(height: height * 0.03),
              // Popular Places Section
              HeaderComponent(),
              SizedBox(height: height * 0.03),
              // Filter Buttons Section
              HomeFilter(),

            ],
          ),
        ),
      ),
    );
  }

}

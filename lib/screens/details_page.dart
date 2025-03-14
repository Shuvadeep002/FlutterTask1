import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/destination/destination_bloc.dart';
import '../bloc/favourite/favourite_bloc.dart';
import '../constants/destination_data_model.dart';

class DestinationDetailsPage extends StatelessWidget {
  const DestinationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<DestinationBloc, DestinationState>(
        builder: (context, state) {
          if (state is DestinationLoaded) {
            Destination destination = state.destinations;
            return BlocBuilder<FavouriteBloc, FavouriteState>(
                builder: (context, favState) {
              bool isFavourite = false;
              if (favState is FavouriteLoaded) {
                isFavourite =
                    favState.favorites.any((fav) => fav.id == destination.id);
              }
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(width * 0.05),
                  child: Column(
                    children: [
                      // Background Image
                      Container(
                        margin: EdgeInsets.only(top: width * 0.05),
                        width: width,
                        height: height * 0.5,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          image: DecorationImage(
                            image: AssetImage(destination.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 16,
                              child: _buildCircularButton(
                                'assets/icons/arrow_left_icon.svg',
                                () => context.pop(),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 16,
                              child: GestureDetector(
                                onTap: () {
                                  if (isFavourite) {
                                    context.read<FavouriteBloc>().add(
                                          RemoveFromFavorites(destination),
                                        );
                                  } else {
                                    context.read<FavouriteBloc>().add(
                                          AddToFavorites(destination),
                                        );
                                  }
                                },
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  padding: const EdgeInsets.all(13),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    isFavourite
                                        ? 'assets/icons/selected_bookmark_icon.svg'
                                        : 'assets/icons/book_mark_icon.svg',
                                    colorFilter: ColorFilter.mode(
                                      isFavourite
                                          ? Colors.yellow
                                          : Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Title and Price Overlay
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16), // Clip the blur to match the container's shape
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), // Blur intensity
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Title and Location
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              destination.title,
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on, size: 16, color: Colors.white70),
                                                const SizedBox(width: 4),
                                                Text(
                                                  destination.location,
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.white70,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        // Price Section
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Price',
                                              style: GoogleFonts.roboto(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '${destination.minimumPrice}',
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 26),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tabs Section
                          Row(
                            children: [
                              _buildTab('Overview', isActive: true,onPressed: (){}),
                              SizedBox(width: 24),
                              _buildTab('Details', isActive: false,onPressed: (){}),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Icon and Information Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoItem(
                                  "assets/icons/clock_icon_selected.svg",
                                  destination.travelTime),
                              _buildInfoItem("assets/icons/atmosphere_icon.svg",
                                  '${destination.temperature}°C'),
                              _buildInfoItem("assets/icons/star_icon.svg",
                                  destination.rating.toString()),
                            ],
                          ),
                          const SizedBox(height: 26),

                          // Description
                          SizedBox(
                            height: height * 0.17,
                            width: double.infinity,
                            child: Text(
                              destination.details,
                              style: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 14,
                                height: 1.5,
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.fade,
                            ),
                          ),

                          SizedBox(height: 24),

                          // Book Now Button
                          SizedBox(
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
                                    'Book Now',
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // Helper Function for Back and Bookmark Buttons
  Widget _buildCircularButton(String icon, VoidCallback onTap) {
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

  // Helper Function for Tabs
  Widget _buildTab(String title, {bool isActive = false, required VoidCallback onPressed}) {
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


  // Helper Function for Info Icons
  Widget _buildInfoItem(String icon, String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: StaticColors.platinum,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              height: 16,
              width: 16,
              child: SvgPicture.asset(icon),
            ),
          ),
        ),
        // Icon(icon, color: Colors.grey, size: 20),
        SizedBox(width: 8,height: 8,),
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/favourite/favourite_bloc.dart';
import '../constants/destination_data_model.dart';
import 'circular_btn.dart';

class ImageCard extends StatelessWidget {
  final Destination destination;
  final double width;
  final double height;
  final bool isFavourite;
  final bool hideBackBtn;

  const ImageCard(
      {super.key,
      required this.destination,
      required this.width,
      required this.height,
      required this.isFavourite,
      this.hideBackBtn = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: width * 0.05),
      width: width,
      height: height * 0.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        image: DecorationImage(
          image: AssetImage(destination.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          if (!hideBackBtn)
            Positioned(
              top: 20,
              left: 16,
              child: CircularButton(
                icon: 'assets/icons/arrow_left_icon.svg',
                onTap: () {
                  context.pop();
                },
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
                    isFavourite ? Colors.yellow : Colors.white,
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
              borderRadius: BorderRadius.circular(16),
              // Clip the blur to match the container's shape
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                // Blur intensity
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
                              const Icon(Icons.location_on,
                                  size: 16, color: Colors.white70),
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
    );
  }
}

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
import '../widgets/book_now_btn.dart';
import '../widgets/circular_btn.dart';
import '../widgets/custom_tab_button.dart';
import '../widgets/details_image_card.dart';
import '../widgets/info_item.dart';

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
            String selectedTitle = state.selectedTitle;
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
                      ImageCard(
                          destination: destination,
                          width: width,
                          height: height,
                          isFavourite: isFavourite),

                      SizedBox(height: 26),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tabs Section
                          Row(
                            children: [
                              CustomTabButton(
                                  title: StaticText.overview,
                                  isActive:
                                      selectedTitle == StaticText.overview,
                                  onPressed: () {
                                    context
                                        .read<DestinationBloc>()
                                        .add(ChangedTitle(StaticText.overview));
                                  }),
                              SizedBox(width: 24),
                              CustomTabButton(
                                  title: StaticText.details,
                                  isActive: selectedTitle == StaticText.details,
                                  onPressed: () {
                                    context
                                        .read<DestinationBloc>()
                                        .add(ChangedTitle(StaticText.details));
                                  }),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Icon and Information Row
                          if (selectedTitle == StaticText.overview) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InfoItem(
                                  icon: "assets/icons/clock_icon_selected.svg",
                                  value: destination.travelTime,
                                ),
                                InfoItem(
                                  icon: "assets/icons/atmosphere_icon.svg",
                                  value: '${destination.temperature}°C',
                                ),
                                InfoItem(
                                  icon: "assets/icons/star_icon.svg",
                                  value: destination.rating.toString(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 26),
                          ],

                          // Description
                          SizedBox(
                            height: selectedTitle == StaticText.overview ? height * 0.17 : height * 0.23,
                            width: double.infinity,
                            child: Text(
                              selectedTitle == StaticText.overview ? destination.overview: destination.details,
                              style: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 14,
                                height: 1.5,
                              ),
                              maxLines: selectedTitle == StaticText.overview ? 4 : 10,
                              overflow: TextOverflow.fade,
                            ),
                          ),

                          SizedBox(height: 24),

                          // Book Now Button
                          BookNowBtn()
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
}

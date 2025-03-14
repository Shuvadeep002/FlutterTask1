import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/destination/destination_bloc.dart';
import '../bloc/favourite/favourite_bloc.dart';
import '../bloc/home_filter/home_filter_bloc.dart';
import '../constants/constants.dart';
import '../constants/destination_data_model.dart';
import '../navigation/route_info.dart';
import '../utils/screen_size.dart';

class HomeFilter extends StatelessWidget {
  const HomeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSize.of(context);
    final width = screenSize.width;
    final height = screenSize.height;

    return BlocProvider(
      create: (_) =>
          HomeFilterBloc()..add(FilterChanged(StaticText.mostViewed)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              children: [
                _buildFilterButton(context, StaticText.mostViewed, width),
                SizedBox(width: width * 0.02),
                _buildFilterButton(context, StaticText.nearby, width),
                SizedBox(width: width * 0.02),
                _buildFilterButton(context, StaticText.latest, width),
              ],
            ),
          ),
          SizedBox(height: height * 0.03),
          BlocBuilder<HomeFilterBloc, HomeFilterState>(
            builder: (context, state) {
              if (state is HomeFilterLoaded) {
                return BlocBuilder<FavouriteBloc, FavouriteState>(
                  builder: (context, favState) {
                    print("BlocBuilder received state: $favState");
                    List<Destination> favourites = [];
                    if (favState is FavouriteLoaded) {
                      favourites = favState.favorites;
                      print("favourites $favourites");
                    }

                    return Container(
                      margin: EdgeInsets.only(left: width * 0.04),
                      child: SizedBox(
                        height: height * 0.4,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.destinations.length,
                          itemBuilder: (context, index) {
                            Destination destination = state.destinations[index];
                            bool isFavourite =
                                favourites.any((d) => d.id == destination.id);
                            return _buildDestinationCard(
                              context,
                              width,
                              destination.title,
                              destination.location,
                              destination.rating,
                              destination.imagePath,
                              () {
                                context
                                    .read<DestinationBloc>()
                                    .add(DesignationChanged(destination));

                                context.push(
                                    AppRoutePath.DestinationDetailsRoutePath);
                              },
                              isFavourite,
                              () {
                                context.read<FavouriteBloc>().add(
                                      isFavourite
                                          ? RemoveFromFavorites(destination)
                                          : AddToFavorites(destination),
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }

  // Filter Button
  Widget _buildFilterButton(BuildContext context, String title, double width) {
    return BlocBuilder<HomeFilterBloc, HomeFilterState>(
      builder: (context, state) {
        bool isActive = state is HomeFilterLoaded && state.filter == title;

        return InkWell(
          onTap: () {
            context.read<HomeFilterBloc>().add(FilterChanged(title));
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.045,
              vertical: width * 0.025,
            ),
            decoration: BoxDecoration(
              color: isActive ? Colors.black : StaticColors.culturedWhite,
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
            child: Text(
              title,
              style: GoogleFonts.roboto(
                color: isActive ? Colors.white : StaticColors.silverChalice,
                fontSize: width * 0.03,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  // Destination Card
  Widget _buildDestinationCard(
    BuildContext context,
    double width,
    String title,
    String location,
    String rating,
    String imagePath,
    VoidCallback onTap,
    bool isFavourite,
    VoidCallback onPressFavourite,
  ) {
    return Container(
      width: width * 0.6,
      margin: EdgeInsets.only(right: width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.075),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned(
              top: width * 0.03,
              right: width * 0.03,
              child: InkWell(
                onTap: onPressFavourite,
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? Colors.red : Colors.white,
                    size: width * 0.05,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: width * 0.03,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.04),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.04,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.white, size: width * 0.04),
                                SizedBox(width: width * 0.01),
                                Text(
                                  location,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: width * 0.035,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.yellow, size: width * 0.04),
                                SizedBox(width: 5),
                                Text(
                                  rating,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: width * 0.035,
                                  ),
                                ),
                              ],
                            )
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
    );
  }
}

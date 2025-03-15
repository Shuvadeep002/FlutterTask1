import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:flutter_task/widgets/details_image_card.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/favourite/favourite_bloc.dart';
import '../constants/destination_data_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          StaticText.favourite,
          style: GoogleFonts.roboto(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLoaded) {
            List<Destination> favorites = state.favorites;

            if (favorites.isEmpty) {
              return Center(
                child: Text(
                  "No favorites yet",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return Container(
              padding: EdgeInsets.symmetric(horizontal:  width * 0.05),
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  Destination destination = favorites[index];

                  return ImageCard(
                    destination: destination,
                    width: width,
                    height: height,
                    isFavourite: true,
                    hideBackBtn: true,
                  );
                },
              ),
            );
          }

          // 🔥 Handle unexpected state gracefully
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}

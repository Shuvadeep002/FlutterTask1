import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/bloc/favourite/favourite_bloc.dart';
import 'package:flutter_task/screens/main_screen.dart';
import 'package:flutter_task/screens/splash_screen.dart';

import 'bloc/destination/destination_bloc.dart';
import 'bloc/home_filter/home_filter_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'constants/constants.dart';
import 'navigation/route_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Set to transparent or any color
        statusBarIconBrightness: Brightness.dark, // For dark icons on light background
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeFilterBloc()..add(FilterChanged(StaticText.mostViewed)),
        ),
        BlocProvider(
          create: (_) => DestinationBloc()..add(ChangedTitle(StaticText.overview)),
        ),
        BlocProvider(
          lazy: false,
          create: (_) {
            final bloc = FavouriteBloc();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              bloc.add(LoadFavorites());
            });
            return bloc;
          },
        ),
        BlocProvider(
          create: (_) => SearchBloc(),
          child: MyApp(),
        ),

      ],
      child:
      MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoute().route,
        ),
    );

  }
}


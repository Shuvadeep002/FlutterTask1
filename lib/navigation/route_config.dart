import 'package:flutter/material.dart';
import 'package:flutter_task/navigation/route_info.dart';
import 'package:flutter_task/screens/details_page.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/screens/main_screen.dart';
import 'package:flutter_task/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  GoRouter route =
  GoRouter(initialLocation: AppRoutePath.SplashRoutePath, routes: [
    GoRoute(
        name: AppRouteName.SplashRouteName,
        path: AppRoutePath.SplashRoutePath,
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen());
        }), GoRoute(
        name: AppRouteName.MainRouteName,
        path: AppRoutePath.MainRoutePath,
        pageBuilder: (context, state) {
          return MaterialPage(child: MainScreen());
        }),
    GoRoute(
        name: AppRouteName.HomeRouteName,
        path: AppRoutePath.HomeRoutePath,
        pageBuilder: (context, state) {
          return MaterialPage(child: HomeScreen());
        }),
    GoRoute(
        name: AppRouteName.DestinationDetailsRouteName,
        path: AppRoutePath.DestinationDetailsRoutePath,
        pageBuilder: (context, state) {
          return MaterialPage(child: DestinationDetailsPage());
        }),

  ]);
}
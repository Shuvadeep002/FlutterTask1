import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../constants/destination_data_model.dart';

part 'favourite_event.dart';

part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<Destination> _favourites = [];

  FavouriteBloc() : super(FavouriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
    on<IsFavorite>(_onIsFavorite);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  // Load favourites from local storage
  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavouriteState> emit,
  ) async {
    emit(FavouriteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favouritesJson = prefs.getString('favourites');
      print("favouritesJson $favouritesJson");
      if (favouritesJson != null) {
        List<dynamic> data = jsonDecode(favouritesJson);
        _favourites = data.map((e) => Destination.fromJson(e)).toList();

      }

      emit(FavouriteLoaded(_favourites));
    } catch (e,stackTrace) {
      print("Error loading favourites: $e\n$stackTrace"); // ✅ Capture detailed error
      emit(FavouriteError('Failed to load favourites'));
    }
  }

  // Add a destination to favourites
  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<FavouriteState> emit,
  ) async {
    if (!_favourites.any((d) => d.id == event.destination.id)) {
      _favourites.add(event.destination);
      await _saveFavourites();
      emit(FavouriteLoaded(List.from(_favourites)));
    }
  }

  // Remove a destination from favourites
  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavouriteState> emit,
  ) async {
    _favourites.removeWhere((d) => d.id == event.destination.id);
    await _saveFavourites();
    emit(FavouriteLoaded(List.from(_favourites)));
  }

  // Toggle favourite status
  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavouriteState> emit,
  ) async {
    final isFavourite = _favourites.any((d) => d.id == event.destination.id);

    if (isFavourite) {
      _favourites.removeWhere((d) => d.id == event.destination.id);
    } else {
      _favourites.add(event.destination);
    }

    await _saveFavourites();
    emit(FavouriteLoaded(List.from(_favourites)));
  }

  // Check if a destination is already in favourites
  void _onIsFavorite(
    IsFavorite event,
    Emitter<FavouriteState> emit,
  ) {
    final isFavourite = _favourites.any((d) => d.id == event.destination.id);
    emit(IsFavoriteState(isFavourite));
  }

  // Save data to shared preferences
  Future<void> _saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(_favourites.map((d) => d.toJson()).toList());
    await prefs.setString('favourites', data);
  }
}

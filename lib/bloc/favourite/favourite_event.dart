part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteEvent {}

// Add a destination to favorites
class AddToFavorites extends FavouriteEvent {
  final Destination destination;

  AddToFavorites(this.destination);
}

// Remove a destination from favorites
class RemoveFromFavorites extends FavouriteEvent {
  final Destination destination;

  RemoveFromFavorites(this.destination);
}

// Toggle favorite status
class ToggleFavorite extends FavouriteEvent {
  final Destination destination;

  ToggleFavorite(this.destination);
}

// Load all favorites
class LoadFavorites extends FavouriteEvent {}

// Check if a destination is in favorites
class IsFavorite extends FavouriteEvent {
  final Destination destination;

  IsFavorite(this.destination);
}

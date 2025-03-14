part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLoading extends FavouriteState {}

final class FavouriteLoaded extends FavouriteState {
  final List<Destination> favorites;

  FavouriteLoaded(this.favorites);
}

final class FavouriteError extends FavouriteState {
  final String message;

  FavouriteError(this.message);
}

final class IsFavoriteState extends FavouriteState {
  final bool isFavorite;

  IsFavoriteState(this.isFavorite);
}

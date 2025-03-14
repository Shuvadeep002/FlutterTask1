part of 'home_filter_bloc.dart';

@immutable
sealed class HomeFilterState {}

final class HomeFilterInitial extends HomeFilterState {}

class HomeFilterLoaded extends HomeFilterState {
  final String filter;
  final List<Destination> destinations;

  HomeFilterLoaded({
    required this.filter,
    required this.destinations,
  });
}

part of 'home_filter_bloc.dart';

@immutable
sealed class HomeFilterEvent {}

class FilterChanged extends HomeFilterEvent {
  final String filter;
  FilterChanged(this.filter);
}

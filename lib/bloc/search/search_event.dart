part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class SelectSearchItem extends SearchEvent {
  final String item;

  SelectSearchItem(this.item);
}

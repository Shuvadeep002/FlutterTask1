part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<String> results;

  SearchSuccess(this.results);
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure(this.error);
}

class SearchItemSelected extends SearchState {
  final List<String> results;
  final String selectedItem;

  SearchItemSelected(this.results, this.selectedItem);
}

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    // Add debounce
    on<SearchQueryChanged>(
          (event, emit) async {
        if (event.query.isEmpty) {
          emit(SearchInitial());
          return;
        }

        emit(SearchLoading());

        try {
          final response = await http.get(
            Uri.parse('https://dummyjson.com/posts/search?q=${event.query}'),
          );

          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final List<String> results = (data['posts'] as List)
                .map((post) => post['title'] as String)
                .toList();

            emit(SearchSuccess(results));
          } else {
            emit(SearchFailure('Failed to load search results'));
          }
        } catch (e) {
          emit(SearchFailure("Please try again after some time"));
        }
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<SelectSearchItem>((event, emit) {
      if (state is SearchSuccess) {
        final currentState = state as SearchSuccess;
        emit(SearchItemSelected(currentState.results, event.item));
      } else if (state is SearchItemSelected) {
        final currentState = state as SearchItemSelected;
        emit(SearchItemSelected(currentState.results, event.item));
      }
    });

  }

  // Debounce transformer
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) =>
        events.debounceTime(duration).switchMap(mapper);
  }
}

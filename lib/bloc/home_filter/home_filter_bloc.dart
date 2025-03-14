import 'package:bloc/bloc.dart';
import 'package:flutter_task/constants/destination_data_model.dart';
import 'package:meta/meta.dart';

import '../../constants/constants.dart';
import '../../constants/destinationData.dart';

part 'home_filter_event.dart';
part 'home_filter_state.dart';

class HomeFilterBloc extends Bloc<HomeFilterEvent, HomeFilterState> {
  HomeFilterBloc() : super(HomeFilterInitial()) {
    on<FilterChanged>((event, emit) {
      if (event.filter == StaticText.mostViewed) {
        emit(HomeFilterLoaded(
          filter: event.filter,
          destinations: mostViewDestinations,
        ));
      } else if (event.filter == StaticText.nearby) {
        emit(HomeFilterLoaded(
          filter: event.filter,
          destinations: nearestDestinations,
        ));
      } else if (event.filter == StaticText.latest) {
        emit(HomeFilterLoaded(
          filter: event.filter,
          destinations: latestDestinations,
        ));
      }
    });
  }
}

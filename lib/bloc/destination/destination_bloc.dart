import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../constants/constants.dart';
import '../../constants/destination_data_model.dart';

part 'destination_event.dart';
part 'destination_state.dart';

class DestinationBloc extends Bloc<DestinationEvent, DestinationState> {
  DestinationBloc() : super(DestinationInitial()) {
    on<DesignationChanged>((event, emit) {
      emit(DestinationLoaded(
        destinations: event.destinations,
        selectedTitle: StaticText.overview, // Default tab
      ));
    });

    on<ChangedTitle>((event, emit) {
      if (state is DestinationLoaded) {
        final currentState = state as DestinationLoaded;
        emit(DestinationLoaded(
          destinations: currentState.destinations,
          selectedTitle: event.selectedTitle,
        ));
      }
    });
  }
}

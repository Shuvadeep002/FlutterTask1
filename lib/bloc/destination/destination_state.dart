part of 'destination_bloc.dart';

@immutable
abstract class DestinationState {}

class DestinationInitial extends DestinationState {}

class DestinationLoaded extends DestinationState {
  final Destination destinations;
  final String selectedTitle;

  DestinationLoaded({
    required this.destinations,
    required this.selectedTitle,
  });
}

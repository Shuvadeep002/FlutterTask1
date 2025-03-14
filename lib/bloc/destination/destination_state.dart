part of 'destination_bloc.dart';

@immutable
abstract class DestinationState {}

class DestinationInitial extends DestinationState {}

class DestinationLoaded extends DestinationState {
  final Destination destinations;
  DestinationLoaded({required this.destinations});
}

class TitleLoaded extends DestinationState {
  final String selectedTitle;
  TitleLoaded({required this.selectedTitle});
}

part of 'destination_bloc.dart';

@immutable
abstract class DestinationEvent {}

class DesignationChanged extends DestinationEvent {
  final Destination destinations;
  DesignationChanged(this.destinations);
}

class ChangedTitle extends DestinationEvent {
  final String selectedTitle;
  ChangedTitle(this.selectedTitle);
}

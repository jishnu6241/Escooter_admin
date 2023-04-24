part of 'ride_bloc.dart';

@immutable
abstract class RideState {}

class RideInitialState extends RideState {}

class RideSuccessState extends RideState {
  final List<Map<String, dynamic>> rides;

  RideSuccessState({required this.rides});
}

class RideLoadingState extends RideState {}

class RideFailureState extends RideState {
  final String message;

  RideFailureState(
      {this.message =
          'Something went wrong, Please check your connection and try again!.'});
}

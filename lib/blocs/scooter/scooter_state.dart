part of 'scooter_bloc.dart';

@immutable
abstract class ScooterState {}

class ScooterInitialState extends ScooterState {}

class ScooterLoadingState extends ScooterState {}

class ScooterSuccessState extends ScooterState {
  final List<Map<String, dynamic>> scooters;

  ScooterSuccessState({required this.scooters});
}

class ScooterFailureState extends ScooterState {
  final String message;
  ScooterFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

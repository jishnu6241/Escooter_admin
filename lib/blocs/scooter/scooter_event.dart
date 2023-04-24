part of 'scooter_bloc.dart';

@immutable
abstract class ScooterEvent {}

class AddScooterEvent extends ScooterEvent {
  final String plateNo;
  final int parkedHubId;

  AddScooterEvent({
    required this.plateNo,
    required this.parkedHubId,
  });
}

class EditScooterEvent extends ScooterEvent {
  final String plateNo;
  final int parkedHubId;
  final int scooterId;

  EditScooterEvent({
    required this.scooterId,
    required this.plateNo,
    required this.parkedHubId,
  });
}

class DeleteScooterEvent extends ScooterEvent {
  final int id;

  DeleteScooterEvent({
    required this.id,
  });
}

class GetAllScooterEvent extends ScooterEvent {
  final String? query;
  final String status;

  GetAllScooterEvent({this.query, this.status = 'ride'});
}

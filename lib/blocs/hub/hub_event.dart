part of 'hub_bloc.dart';

@immutable
abstract class HubEvent {}

class AddHubEvent extends HubEvent {
  final String name, address;
  final LatLng latLng;

  AddHubEvent({
    required this.name,
    required this.address,
    required this.latLng,
  });
}

class EditHubEvent extends HubEvent {
  final String name, address;
  final LatLng? latLng;
  final int hubId;

  EditHubEvent({
    required this.name,
    required this.address,
    this.latLng,
    required this.hubId,
  });
}

class DeleteHubEvent extends HubEvent {
  final int id;

  DeleteHubEvent({
    required this.id,
  });
}

class GetAllHubEvent extends HubEvent {
  final String? query;

  GetAllHubEvent({
    this.query,
  });
}

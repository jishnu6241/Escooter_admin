part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetAllUsersEvent extends UsersEvent {
  final String? query;

  GetAllUsersEvent({this.query});
}

class AddUsersEvent extends UsersEvent {
  final String name, phone, bankName, accountNo, bankIfsc;
  final PlatformFile file;

  AddUsersEvent({
    required this.name,
    required this.phone,
    required this.bankName,
    required this.accountNo,
    required this.bankIfsc,
    required this.file,
  });
}

class EditUsersEvent extends UsersEvent {
  final String name, phone, bankName, accountNo, bankIfsc;
  final PlatformFile? file;

  EditUsersEvent({
    required this.name,
    required this.phone,
    required this.bankName,
    required this.accountNo,
    required this.bankIfsc,
    this.file,
  });
}

class DeleteUsersEvent extends UsersEvent {
  final int id;

  DeleteUsersEvent({
    required this.id,
  });
}

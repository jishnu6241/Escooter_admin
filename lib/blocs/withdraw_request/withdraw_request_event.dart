part of 'withdraw_request_bloc.dart';

@immutable
abstract class WithdrawRequestEvent {}

class GetAllWithdrawRequestEvent extends WithdrawRequestEvent {
  final String status;

  GetAllWithdrawRequestEvent({this.status = 'pending'});
}

class UpdateWithdrawRequestStatusEvent extends WithdrawRequestEvent {
  final String status;

  UpdateWithdrawRequestStatusEvent({
    required this.status,
  });
}

class AddWithdrawRequestEvent extends WithdrawRequestEvent {
  AddWithdrawRequestEvent();
}

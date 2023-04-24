part of 'withdraw_request_bloc.dart';

@immutable
abstract class WithdrawRequestState {}

class WithdrawRequestInitialState extends WithdrawRequestState {}

class WithdrawRequestLoadingState extends WithdrawRequestState {}

class WithdrawRequestSuccessState extends WithdrawRequestState {
  final List<Map<String, dynamic>> requests;

  WithdrawRequestSuccessState({required this.requests});
}

class WithdrawRequestFailureState extends WithdrawRequestState {
  final String message;
  WithdrawRequestFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

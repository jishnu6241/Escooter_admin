part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitialState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersSuccessState extends UsersState {
  final List<Map<String, dynamic>> users;

  UsersSuccessState({required this.users});
}

class UsersFailureState extends UsersState {
  final String message;
  UsersFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

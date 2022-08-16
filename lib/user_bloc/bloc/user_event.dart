part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UsersGetUserEvent extends UserEvent {
  final int count;

  UsersGetUserEvent(this.count);
}

class UsersGetUserJobEvent extends UserEvent {
  final int count;

  UsersGetUserJobEvent(this.count);
}

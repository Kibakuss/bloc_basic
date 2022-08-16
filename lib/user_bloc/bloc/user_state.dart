part of 'user_bloc.dart';

class UserState {
  final List<User> users;
  final List<Job> job;
  final bool isLoading;

  UserState(
      {this.isLoading = false, this.users = const [], this.job = const []});

  UserState copyWith(
      {final List<User>? users,
      final List<Job>? job,
      final bool isLoading = false}) {
    return UserState(
        users: users ?? this.users, job: job ?? this.job, isLoading: isLoading);
  }
}

class User {
  final String name;
  final int id;

  User({required this.name, required this.id});
}

class Job {
  final String title;
  final int id;

  Job({required this.title, required this.id});
}

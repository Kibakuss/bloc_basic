import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UsersGetUserEvent>(_onGetUser);
    on<UsersGetUserJobEvent>(_onGetUserJob);
  }

  _onGetUser(UsersGetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final users = List.generate(
        event.count, (index) => User(name: 'user name', id: index));
    emit(state.copyWith(users: users));
  }

  _onGetUserJob(UsersGetUserJobEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final job =
        List.generate(event.count, (index) => Job(title: 'title', id: index));
    emit(state.copyWith(job: job));
  }
}

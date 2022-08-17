import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_basic/counter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CounterBloc counterBloc;
  late final StreamSubscription counterBlocSubscription;
  UserBloc(this.counterBloc) : super(UserState()) {
    on<UsersGetUserEvent>(_onGetUser);
    on<UsersGetUserJobEvent>(_onGetUserJob);
    counterBlocSubscription = counterBloc.stream.listen((state) {
      if (state <= 0) {
        add(UsersGetUserEvent(0));
        add(UsersGetUserJobEvent(0));
      }
    });

    @override
    Future<void> close() async {
      counterBlocSubscription.cancel();
      return super.close();
    }
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

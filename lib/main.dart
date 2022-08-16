import 'package:bloc_basic/counter_bloc.dart';
import 'package:bloc_basic/user_bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc()..add(CounterIncEvent());
    final userBloc = UserBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => counterBloc,
        ),
        BlocProvider<UserBloc>(
          create: (context) => userBloc,
        ),
      ],
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                counterBloc.add(CounterIncEvent());
              },
              icon: const Icon(Icons.plus_one),
            ),
            IconButton(
              onPressed: () {
                counterBloc.add(CounterDecEvent());
              },
              icon: const Icon(
                Icons.exposure_minus_1,
              ),
            ),
            IconButton(
              onPressed: () {
                userBloc.add(UsersGetUserEvent(counterBloc.state));
              },
              icon: const Icon(
                Icons.person,
              ),
            ),
            IconButton(
              onPressed: () {
                userBloc.add(UsersGetUserJobEvent(counterBloc.state));
              },
              icon: const Icon(
                Icons.work,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                BlocBuilder<CounterBloc, int>(
                    bloc: counterBloc,
                    builder: (context, state) {
                      return Text(state.toString());
                    }),
                BlocBuilder<UserBloc, UserState>(
                    bloc: userBloc,
                    builder: (context, state) {
                      final users = state.users;
                      final job = state.job;
                      return Column(
                        children: [
                          if (state.isLoading)
                            const CircularProgressIndicator(),
                          if (users.isNotEmpty)
                            ...users.map((e) => Text(e.name)),
                          if (job.isNotEmpty) ...job.map((e) => Text(e.title))
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
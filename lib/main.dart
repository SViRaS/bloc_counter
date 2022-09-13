import 'package:counter_bloc/counter_bloc.dart';
import 'package:counter_bloc/user_bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counter_bloc = CounterBloc()..add(CounterDel());
  final user_bloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  counter_bloc.add(CounterAdd());
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  counter_bloc.add(CounterDel());
                },
                icon: Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  user_bloc.add(UserGetUsersEvent(counter_bloc.state));
                },
                icon: Icon(Icons.person)),
                IconButton(
                onPressed: () {
                  user_bloc.add(UserGetUsersJobEvent(counter_bloc.state));
                },
                icon: Icon(Icons.work)),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(children: [
              BlocBuilder<CounterBloc, int>(
                bloc: counter_bloc,
                builder: (context, state) => Text(
                  state.toString(),
                  style: TextStyle(fontSize: 50, color: Colors.black),
                ),
              ),
              BlocBuilder<UserBloc, UserState>(
                  bloc: user_bloc,
                  builder: (context, state) {
                    final users = state.users;
                    final job = state.job;
                    return Column(
                      children: [
                        if (state.isLoading)
                          CircularProgressIndicator(),
                        if (users.isNotEmpty)
                          ...users.map((e) => Text(e.name)),
                          if (job.isNotEmpty)
                          ...job.map((e) => Text(e.name)),
                      ],
                    );
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}

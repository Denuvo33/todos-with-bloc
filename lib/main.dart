import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/bloc/todo_bloc.dart';
import 'package:todos_bloc/screens/my_home_screen.dart';
import 'package:todos_bloc/service/todo_db_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodoBloc(todoDb: TodoDbService())..add(ReadAllTodoEvent()),
      child: MaterialApp(
        title: 'Todo App',
        home: const MyHomeScreen(),
      ),
    );
  }
}

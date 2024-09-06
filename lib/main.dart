import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/bloc/auth/auth_bloc.dart';
import 'package:todos_bloc/bloc/todo/todo_bloc.dart';
import 'package:todos_bloc/firebase_options.dart';
import 'package:todos_bloc/screens/login_screen.dart';
import 'package:todos_bloc/service/todo_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => TodoBloc(TodoService())
            ..add(
              LoadTodosEvent(),
            ),
        ),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}

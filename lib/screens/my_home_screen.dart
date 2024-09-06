import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/bloc/auth/auth_bloc.dart';
import 'package:todos_bloc/bloc/todo/todo_bloc.dart';
import 'package:todos_bloc/screens/login_screen.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        actions: [
          IconButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                    SignOutEvent(),
                  );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (!state.isSignedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          }
        },
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('error ${state.error}'),
                ),
              );
              return Center(
                child: Text('Error: ${state.error}'),
              );
            }

            if (state.todos.isEmpty) {
              return Center(child: Text('No Todos found.'));
            }

            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      final updatedTodo = todo.copyWith(isCompleted: value!);
                      context
                          .read<TodoBloc>()
                          .add(UpdateTodoEvent(updatedTodo));
                    },
                  ),
                  onLongPress: () {
                    context.read<TodoBloc>().add(DeleteTodoEvent(todo.id));
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateTodoDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreateTodoDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Todo'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = _controller.text.trim();
                if (title.isNotEmpty) {
                  context.read<TodoBloc>().add(CreateTodoEvent(title));
                }
                Navigator.of(context).pop();
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}

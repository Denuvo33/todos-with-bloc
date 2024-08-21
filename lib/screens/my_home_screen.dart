import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/bloc/todo_bloc.dart';
import 'package:todos_bloc/model/todo_model.dart';
import 'package:todos_bloc/screens/create_todo_screen.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            return Visibility(
              visible: !state.isLoading,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: state.todos.isEmpty
                  ? Center(
                      child: Text(state.error == '' ? 'No todos' : state.error))
                  : ListView.builder(
                      itemCount: state.todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateTodoScreen(
                                            todo: state.todos[index],
                                          )));
                            },
                            title: Text(state.todos[index].title),
                            trailing: IconButton(
                                onPressed: () {
                                  context.read<TodoBloc>().add(
                                      DeleteTodoEvent(state.todos[index].id!));
                                },
                                icon: Icon(Icons.delete)),
                            leading: Checkbox(
                              value: state.todos[index].isCompleted,
                              onChanged: (value) {
                                context.read<TodoBloc>().add(CompletedTodo(
                                      TodoModel(
                                        id: state.todos[index].id,
                                        title: state.todos[index].title,
                                        isCompleted: value!,
                                      ),
                                    ));
                              },
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateTodoScreen(
                        todo: null,
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

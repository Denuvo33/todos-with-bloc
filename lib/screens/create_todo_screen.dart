import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/bloc/todo_bloc.dart';
import 'package:todos_bloc/model/todo_model.dart';

// ignore: must_be_immutable
class CreateTodoScreen extends StatelessWidget {
  TodoModel? todo;
  CreateTodoScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    var isEditing = todo != null;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController _titleController =
        TextEditingController(text: isEditing ? todo!.title : '');
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Todo' : 'Create Todo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Todo Title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (isEditing) {
                        context.read<TodoBloc>().add(UpdateTodoEvent(TodoModel(
                            id: todo!.id!,
                            title: _titleController.text,
                            isCompleted: todo!.isCompleted)));
                        Navigator.pop(context);
                      } else {
                        final TodoModel newTodo =
                            TodoModel(title: _titleController.text);
                        context.read<TodoBloc>().add(CreateTodoEvent(newTodo));
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(isEditing ? 'Update' : 'Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

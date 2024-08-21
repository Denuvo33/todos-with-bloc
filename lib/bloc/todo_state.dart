part of 'todo_bloc.dart';

class TodoState {
  List<TodoModel> todos;
  final bool isLoading;
  final String error;

  TodoState({this.todos = const [], this.isLoading = false, this.error = ''});

  TodoState copyWith({List<TodoModel>? todos, bool? isLoading, String? error}) {
    return TodoState(
        todos: todos ?? this.todos,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }
}

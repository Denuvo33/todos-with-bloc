part of 'todo_bloc.dart';

abstract class TodoEvent {}

class LoadTodosEvent extends TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final String title;
  CreateTodoEvent(this.title);
}

class UpdateTodoEvent extends TodoEvent {
  final TodoModel todo;
  UpdateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  DeleteTodoEvent(this.id);
}

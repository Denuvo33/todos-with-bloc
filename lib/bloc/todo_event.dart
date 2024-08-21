part of 'todo_bloc.dart';

class TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final TodoModel todo;
  CreateTodoEvent(this.todo);
}

class CompletedTodo extends TodoEvent {
  final TodoModel todo;
  CompletedTodo(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  final TodoModel todo;
  UpdateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  DeleteTodoEvent(this.id);
}

class ReadAllTodoEvent extends TodoEvent {}

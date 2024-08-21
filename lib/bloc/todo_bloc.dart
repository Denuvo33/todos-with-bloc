import 'package:todos_bloc/model/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/service/todo_db_service.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoDbService todoDb;
  TodoBloc({required this.todoDb}) : super(TodoState(todos: [])) {
    on<ReadAllTodoEvent>(
      ((event, emit) async {
        emit(state.copyWith(isLoading: true));
        try {
          final todos = await todoDb.getTodos();
          emit(state.copyWith(todos: todos, isLoading: false));
        } catch (e) {
          emit(state.copyWith(isLoading: false, error: e.toString()));
        }
      }),
    );

    on<CreateTodoEvent>(((event, emit) async {
      await todoDb.insertTodo(event.todo);
      add(ReadAllTodoEvent());
    }));

    on<UpdateTodoEvent>(((event, emit) async {
      await todoDb.updateTodo(event.todo);
      add(ReadAllTodoEvent());
    }));

    on<DeleteTodoEvent>(((event, emit) async {
      await todoDb.deleteTodo(event.id);
      add(ReadAllTodoEvent());
    }));

    on<CompletedTodo>((event, emit) async {
      final updatedTodo = TodoModel(
        id: event.todo.id,
        title: event.todo.title,
        isCompleted: event.todo.isCompleted,
      );
      await todoDb.updateTodo(updatedTodo);
      final todos = await todoDb.getTodos();
      emit(state.copyWith(todos: todos));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:todos_bloc/model/todo_model.dart';
import 'package:todos_bloc/service/todo_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService todoService;

  TodoBloc(this.todoService) : super(TodoState()) {
    on<LoadTodosEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final todos = await todoService.getTodos();
        emit(state.copyWith(todos: todos, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    });

    on<CreateTodoEvent>((event, emit) async {
      try {
        await todoService.createTodo(event.title);
        add(LoadTodosEvent());
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    });

    on<UpdateTodoEvent>((event, emit) async {
      try {
        await todoService.updateTodo(event.todo);
        add(LoadTodosEvent());
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    });

    on<DeleteTodoEvent>((event, emit) async {
      try {
        await todoService.deleteTodo(event.id);
        add(LoadTodosEvent());
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    });
  }
}

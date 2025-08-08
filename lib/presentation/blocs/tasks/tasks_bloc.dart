import 'package:flutter_bloc/flutter_bloc.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';
import '../../../domain/usecases/get_tasks.dart';
import '../../../domain/usecases/add_task.dart';
import '../../../domain/usecases/update_task.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;

  TasksBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
  }) : super(TasksLoading()) {
    on<LoadTasks>(_onLoad);
    on<AddTaskEvent>(_onAdd);
    on<UpdateTaskEvent>(_onUpdate);
    on<ChangeFilterEvent>(_onChangeFilter);
  }

  Future<void> _onLoad(LoadTasks event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await getTasks();
      emit(TasksLoaded(tasks: tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> _onAdd(AddTaskEvent event, Emitter<TasksState> emit) async {
    await addTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onUpdate(UpdateTaskEvent event, Emitter<TasksState> emit) async {
    await updateTask(event.task);
    add(LoadTasks());
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<TasksState> emit) {
    final s = state;
    if (s is TasksLoaded) {
      emit(TasksLoaded(tasks: s.tasks, filter: event.filter));
    }
  }
}

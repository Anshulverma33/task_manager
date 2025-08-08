import 'package:equatable/equatable.dart';
import '../../../domain/entities/task.dart';
import '../../../core/enums.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
  @override
  List<Object?> get props => [];
}

class LoadTasks extends TasksEvent {}

class AddTaskEvent extends TasksEvent {
  final Task task;
  const AddTaskEvent(this.task);
  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TasksEvent {
  final Task task;
  const UpdateTaskEvent(this.task);
  @override
  List<Object?> get props => [task];
}

class ChangeFilterEvent extends TasksEvent {
  final TaskStatus? filter;
  const ChangeFilterEvent(this.filter);
  @override
  List<Object?> get props => [filter];
}

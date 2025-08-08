import 'package:equatable/equatable.dart';
import '../../../domain/entities/task.dart';
import '../../../core/enums.dart';

abstract class TasksState extends Equatable {
  const TasksState();
  @override
  List<Object?> get props => [];
}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<Task> tasks;
  final TaskStatus? filter;
  const TasksLoaded({required this.tasks, this.filter});

  @override
  List<Object?> get props => [tasks, filter];
}

class TasksError extends TasksState {
  final String message;
  const TasksError(this.message);
  @override
  List<Object?> get props => [message];
}

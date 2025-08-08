import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_ds.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource local;

  TaskRepositoryImpl(this.local);

  @override
  Future<void> addTask(Task task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      status: task.status,
      dueDate: task.dueDate,
    );
    await local.saveTask(model);
  }

  @override
  Future<List<Task>> getTasks() => local.fetchTasks();

  @override
  Future<void> updateTask(Task task) => addTask(task);
}

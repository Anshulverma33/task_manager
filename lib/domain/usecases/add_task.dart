import '../repositories/task_repository.dart';
import '../entities/task.dart';

class AddTask {
  final TaskRepository repo;
  AddTask(this.repo);

  Future<void> call(Task task) => repo.addTask(task);
}

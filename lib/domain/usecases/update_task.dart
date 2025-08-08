import '../repositories/task_repository.dart';
import '../entities/task.dart';

class UpdateTask {
  final TaskRepository repo;
  UpdateTask(this.repo);

  Future<void> call(Task task) => repo.updateTask(task);
}

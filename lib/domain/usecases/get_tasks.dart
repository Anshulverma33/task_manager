import '../repositories/task_repository.dart';
import '../entities/task.dart';

class GetTasks {
  final TaskRepository repo;
  GetTasks(this.repo);

  Future<List<Task>> call() => repo.getTasks();
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import '../../core/enums.dart';

class TaskLocalDataSource {
  static const _key = 'tasks';

  Future<List<TaskModel>> fetchTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString) as List;
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      // Initial dummy data if no saved tasks
      final initial = [
        TaskModel(
          id: '1',
          title: 'Buy groceries',
          description: 'Milk, Eggs, Bread',
          status: TaskStatus.todo,
          dueDate: DateTime.now().add(Duration(days: 1)),
        ),
        TaskModel(
          id: '2',
          title: 'Send invoice',
          description: 'Project ABC invoice',
          status: TaskStatus.inProgress,
          dueDate: DateTime.now().add(Duration(days: 2)),
        ),
      ];
      await _saveList(initial);
      return initial;
    }
  }

  Future<void> saveTask(TaskModel task) async {
    final tasks = await fetchTasks();
    final updated = List<TaskModel>.from(tasks);
    updated.removeWhere((t) => t.id == task.id);
    updated.add(task);
    await _saveList(updated);
  }

  Future<void> _saveList(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }
}

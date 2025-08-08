import '../../domain/entities/task.dart';
import '../../core/enums.dart';

class TaskModel extends Task {
  const TaskModel({
    required String id,
    required String title,
    String? description,
    required TaskStatus status,
    required DateTime dueDate,
  }) : super(id: id, title: title, description: description, status: status, dueDate: dueDate);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: TaskStatus.values[json['status'] as int],
      dueDate: DateTime.parse(json['dueDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.index,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}

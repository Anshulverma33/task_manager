import 'package:flutter/material.dart';
import '../../../core/enums.dart';
import '../../../domain/entities/task.dart';
import '../pages/add_edit_task_sheet.dart';
import '../tasks/tasks_bloc.dart';
import '../tasks/tasks_event.dart';
import 'status_chip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({required this.task});

  Color _color(TaskStatus s) {
    switch (s) {
      case TaskStatus.todo:
        return Colors.orange;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.done:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => AddEditTaskSheet(task: task),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              StatusChip(status: task.status),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    if ((task.description ?? '').isNotEmpty) ...[
                      SizedBox(height: 6),
                      Text(task.description ?? '', style: TextStyle(color: Colors.grey[700])),
                    ],
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                        SizedBox(width: 6),
                        Text('${task.dueDate.toLocal().toIso8601String().substring(0, 10)}'),
                      ],
                    )
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (val) {
                  if (val == 'todo') _updateStatus(context, TaskStatus.todo);
                  if (val == 'inProgress') _updateStatus(context, TaskStatus.inProgress);
                  if (val == 'done') _updateStatus(context, TaskStatus.done);
                },
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'todo', child: Text('To Do')),
                  PopupMenuItem(value: 'inProgress', child: Text('In Progress')),
                  PopupMenuItem(value: 'done', child: Text('Done')),
                ],
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateStatus(BuildContext context, TaskStatus status) {
    final bloc = context.read<TasksBloc>();
    bloc.add(UpdateTaskEvent(task.copyWith(status: status)));
  }
}

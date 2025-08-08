import 'package:flutter/material.dart';
import '../../../core/enums.dart';

class StatusChip extends StatelessWidget {
  final TaskStatus status;
  const StatusChip({required this.status});

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
    final color = _color(status);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          SizedBox(width: 8),
          Text(status.label, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

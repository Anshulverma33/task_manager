import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../core/enums.dart';
import '../../../domain/entities/task.dart';
import '../tasks/tasks_bloc.dart';
import '../tasks/tasks_event.dart';

class AddEditTaskSheet extends StatefulWidget {
  final Task? task;
  AddEditTaskSheet({this.task});
  @override
  _AddEditTaskSheetState createState() => _AddEditTaskSheetState();
}

class _AddEditTaskSheetState extends State<AddEditTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _desc;
  TaskStatus _status = TaskStatus.todo;
  DateTime _due = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _desc = widget.task!.description;
      _status = widget.task!.status;
      _due = widget.task!.dueDate;
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final id = widget.task?.id ?? Uuid().v4();
    final task = Task(
      id: id,
      title: _title!.trim(),
      description: _desc?.trim(),
      status: _status,
      dueDate: _due,
    );
    final bloc = context.read<TasksBloc>();
    if (widget.task == null) {
      bloc.add(AddTaskEvent(task));
    } else {
      bloc.add(UpdateTaskEvent(task));
    }
    Navigator.of(context).pop();
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _due,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _due = picked);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.task == null ? 'Add Task' : 'Edit Task', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _title,
                      decoration: InputDecoration(labelText: 'Title'),
                      validator: (v) {
                        if (v == null || v.trim().length < 3) return 'Title must be at least 3 characters';
                        return null;
                      },
                      onSaved: (v) => _title = v,
                    ),
                    TextFormField(
                      initialValue: _desc,
                      decoration: InputDecoration(labelText: 'Description'),
                      onSaved: (v) => _desc = v,
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Status:'),
                        SizedBox(width: 12),
                        DropdownButton<TaskStatus>(
                          value: _status,
                          items: TaskStatus.values
                              .map((s) => DropdownMenuItem(value: s, child: Text(s.label)))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) setState(() => _status = v);
                          },
                        ),
                        Spacer(),
                        TextButton.icon(
                          onPressed: _pickDueDate,
                          icon: Icon(Icons.calendar_today),
                          label: Text('${_due.toLocal().toIso8601String().substring(0, 10)}'),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: _save,
                      child: Text(widget.task == null ? 'Add' : 'Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

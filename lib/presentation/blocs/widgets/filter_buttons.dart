import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/enums.dart';
import '../tasks/tasks_bloc.dart';
import '../tasks/tasks_event.dart';
import '../tasks/tasks_state.dart';

class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        TaskStatus? active;
        if (state is TasksLoaded) active = state.filter;
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: Text('All'),
                selected: active == null,
                onSelected: (_) => context.read<TasksBloc>().add(ChangeFilterEvent(null)),
              ),
              ...TaskStatus.values.map((s) => ChoiceChip(
                label: Text(s.label),
                selected: active == s,
                onSelected: (_) => context.read<TasksBloc>().add(ChangeFilterEvent(s)),
              )),
            ],
          ),
        );
      },
    );
  }
}

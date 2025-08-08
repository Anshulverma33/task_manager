import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../tasks/tasks_bloc.dart';
import '../tasks/tasks_state.dart';
import '../theme/theme_cubit.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/task_card.dart';
import '../pages/add_edit_task_sheet.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) {
                return Icon(mode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode);
              },
            ),
            onPressed: () => themeCubit.toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          FilterButtons(),
          Expanded(
            child: BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is TasksLoading) return Center(child: CircularProgressIndicator());
                if (state is TasksLoaded) {
                  final tasks = state.filter == null
                      ? state.tasks
                      : state.tasks.where((t) => t.status == state.filter).toList();
                  if (tasks.isEmpty) return Center(child: Text('No tasks here. Tap + to add one.'));
                  return ListView.separated(
                    padding: EdgeInsets.all(12),
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8),
                    itemBuilder: (ctx, i) => TaskCard(task: tasks[i]),
                  );
                }
                if (state is TasksError) return Center(child: Text('Error: ${state.message}'));
                return SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) => AddEditTaskSheet(),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/presentation/blocs/pages/task_list_page.dart';
import 'package:task_manager/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:task_manager/presentation/blocs/tasks/tasks_event.dart';
import 'package:task_manager/presentation/blocs/theme/theme_cubit.dart';

import 'data/datasources/task_local_ds.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/usecases/add_task.dart';
import 'domain/usecases/get_tasks.dart';
import 'domain/usecases/update_task.dart';

void main() {
  final local = TaskLocalDataSource();
  final repo = TaskRepositoryImpl(local);
  final getTasks = GetTasks(repo);
  final addTask = AddTask(repo);
  final updateTask = UpdateTask(repo);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TasksBloc(
            getTasks: getTasks,
            addTask: addTask,
            updateTask: updateTask,
          )..add(LoadTasks()),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Task Manager',
          themeMode: themeMode,
          theme: ThemeData(useMaterial3: true, primarySwatch: Colors.indigo, brightness: Brightness.light),
          darkTheme: ThemeData(useMaterial3: true, primarySwatch: Colors.indigo, brightness: Brightness.dark),
          home: TaskListPage(),
        );
      },
    );
  }
}

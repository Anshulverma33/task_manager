# Task Manager (Flutter) — Technical Task

## 📌 Summary
A small **Task Manager** application built with **Flutter**, implementing **Clean Architecture** principles and **BLoC state management**.  
The app allows users to **add, edit, update, filter, and persist tasks**, with light/dark theme switching and a polished UI.

---

## 🏗 Architecture
The project follows a **3-layer Clean Architecture**:

### **1. Presentation Layer**
- Built with Flutter widgets.
- State managed via **flutter_bloc**.
- Contains:
    - `pages/` → UI screens like Task List & Add/Edit Task sheet.
    - `widgets/` → Reusable UI components like `StatusChip`, `TaskCard`, and filter buttons.
    - `blocs/` → BLoC classes for tasks and theme.

### **2. Domain Layer**
- Contains **Entities**, **Repositories (abstract)**, and **UseCases**.
- Defines business rules independent of Flutter framework.
- Use cases:
    - `GetTasks`
    - `AddTask`
    - `UpdateTask`

### **3. Data Layer**
- Contains **Models**, **DataSources**, and **Repository Implementations**.
- Data Source: `TaskLocalDataSource` using **SharedPreferences** to persist tasks.
- Repository Implementation maps domain objects to data models.

---

## 🔄 State Management
- Implemented with **BLoC** pattern (`flutter_bloc`).
- **TasksBloc** handles:
    - Loading tasks from storage
    - Adding new tasks
    - Updating task status/details
    - Filtering tasks by status
- **ThemeCubit** handles:
    - Toggling between Light and Dark themes
    - Persisting theme preference (optional extension)

---

## ✨ Features
- 📋 **Task List** with title, description, due date, and status.
- ➕ **Add Task** via bottom sheet with form validation (title must be ≥ 3 chars).
- ✏️ **Edit Task** from task card tap.
- ✅ **Update Status** via popup menu (To Do / In Progress / Done).
- 🎨 **Color-coded status** + animated `StatusChip` widget.
- 🔍 **Filter Tasks** (All / To Do / In Progress / Done) using `ChoiceChip`s.
- 💾 **Persistent Storage** with `SharedPreferences` — tasks remain after app restart.
- 🌗 **Light/Dark Theme Toggle** via AppBar icon.
- 📱 **Responsive UI** and Material 3 design.

---

## 📂 Folder Structure
```
lib/
  core/
    enums.dart
  data/
    datasources/task_local_ds.dart
    models/task_model.dart
    repositories/task_repository_impl.dart
  domain/
    entities/task.dart
    repositories/task_repository.dart
    usecases/
      get_tasks.dart
      add_task.dart
      update_task.dart
  presentation/
    blocs/
      tasks/
        tasks_bloc.dart
        tasks_event.dart
        tasks_state.dart
      theme/theme_cubit.dart
    pages/
      task_list_page.dart
      add_edit_task_sheet.dart
    widgets/
      filter_buttons.dart
      status_chip.dart
      task_card.dart
main.dart
```

---

## 🚀 How to Run
1. Clone the repository:
```bash
git clone <repo_url>
```
2. Install dependencies:
```bash
flutter pub get
```
3. Run the app:
```bash
flutter run
```

---

## 🧪 Testing
- Verified adding, editing, and filtering tasks.
- Confirmed data persists after app restart.
- Checked light/dark theme toggle works instantly.
- Validated empty state UI when no tasks are present.

---

## 📌 Possible Improvements
- Implement search bar for tasks.
- Add sort & reorder functionality.
- Store theme preference in `SharedPreferences` so it persists between launches.
- Add unit tests & widget tests.
- Use Hive for more structured local storage.

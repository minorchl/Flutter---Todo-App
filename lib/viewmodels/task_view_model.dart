import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker/models/task_model.dart';
import 'package:task_tracker/services/task_local_service.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskLocalService _service;
  List<Task> _tasks = [];
  TaskFilter _filter = TaskFilter.all;

  TaskFilter get filter => _filter;

  TaskViewModel(this._service) {
    loadTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = _service.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _service.addTask(task);
    loadTasks();
  }

  Future<void> editTask(int key, Task task) async {
    await _service.updateTask(key, task);
    loadTasks();
  }

  Future<void> deleteTask(int key) async {
    await _service.deleteTask(key);
    loadTasks();
  }

  Future<void> toggleDone(Task task) async {
    task.isDone = !task.isDone;
    await task.save();
    notifyListeners();
  }

  List<Task> get filteredTasks {
    switch (_filter) {
      case TaskFilter.completed:
        return _tasks.where((t) => t.isDone).toList();
      case TaskFilter.inProgress:
        return _tasks.where((t) => !t.isDone).toList();
      default:
        return _tasks;
    }
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  Map<String, List<Task>> get groupedTasksByDate {
    final grouped = <String, List<Task>>{};
    final formatter = DateFormat('dd/MM/yyyy');
    final now = DateTime.now();
    final todayKey = formatter.format(DateTime(now.year, now.month, now.day));

    for (final task in filteredTasks) {
      final taskDate = DateTime(
        task.deadline.year,
        task.deadline.month,
        task.deadline.day,
      );
      final dateKey = formatter.format(taskDate);
      final displayKey = dateKey == todayKey ? "Today" : dateKey;

      grouped.putIfAbsent(displayKey, () => []).add(task);
    }

    return Map.fromEntries(
      grouped.entries.toList()..sort(
        (b, a) =>
            b.key == "Today"
                ? -1
                : a.key == "Today"
                ? 1
                : b.key.compareTo(a.key),
      ),
    );
  }
}

enum TaskFilter { all, inProgress, completed }

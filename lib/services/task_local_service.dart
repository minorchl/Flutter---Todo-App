import 'package:hive/hive.dart';
import 'package:task_tracker/models/task_model.dart';
import 'package:task_tracker/utils/hive_boxs.dart';

class TaskLocalService {
  Box<Task> get box => Hive.box<Task>(HiveBoxes.tasks);

  List<Task> getTasks() => box.values.toList();

  Future<void> addTask(Task task) => box.add(task);

  Future<void> updateTask(int key, Task task) => box.put(key, task);

  Future<void> deleteTask(int key) => box.delete(key);
}

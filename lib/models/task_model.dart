import 'package:flutter/foundation.dart'; // สำคัญมาก
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject with ChangeNotifier {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime deadline;

  @HiveField(2)
  bool isDone;

  Task({required this.title, required this.deadline, required this.isDone});
}

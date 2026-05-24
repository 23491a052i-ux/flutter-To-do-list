import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  String category;

  @HiveField(3)
  DateTime? dueDate;

  Task({
    required this.title,
    this.isCompleted = false,
    this.category = "General",
    this.dueDate,
  });
}

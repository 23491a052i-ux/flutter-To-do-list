import 'package:hive/hive.dart';
import '../models/task_model.dart';

class Boxes {
  static Box<Task> getTasks() => Hive.box<Task>('tasks');
}

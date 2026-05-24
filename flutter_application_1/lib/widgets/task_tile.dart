import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({required this.task});

  Color getColor() {
    switch (task.category) {
      case "Work":
        return Colors.orange;
      case "Study":
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [getColor().withOpacity(0.7), getColor()],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (val) {
            task.isCompleted = !task.isCompleted;
            task.save();
          },
          activeColor: Colors.white,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: Colors.white,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Category: ${task.category}",
              style: TextStyle(color: Colors.white70),
            ),
            if (task.dueDate != null)
              Text(
                "Due: ${DateFormat.yMMMd().format(task.dueDate!)}",
                style: TextStyle(color: Colors.white70),
              ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.white),
          onPressed: () => task.delete(),
        ),
      ),
    );
  }
}

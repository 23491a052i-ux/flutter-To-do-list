import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../boxes/boxes.dart';
import '../models/task_model.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  String category = "General";
  DateTime? selectedDate;

  void addTask() {
    if (controller.text.isEmpty) return;

    final task = Task(
      title: controller.text,
      category: category,
      dueDate: selectedDate,
    );

    Boxes.getTasks().add(task);

    controller.clear();
    selectedDate = null;
    setState(() {});
  }

  Future pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: Text("✨ My To-Do"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
          ),
        ),
      ),
      body: Column(
        children: [
          // Input UI
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade100, Colors.blue.shade100],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Enter task...",
                    border: InputBorder.none,
                  ),
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: category,
                      items: ["General", "Work", "Study"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() => category = val!);
                      },
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: pickDate,
                      child: Text(
                        selectedDate == null
                            ? "Pick Date"
                            : DateFormat.yMMMd().format(selectedDate!),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.purple),
                      onPressed: addTask,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Task List
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Boxes.getTasks().listenable(),
              builder: (context, Box<Task> box, _) {
                final tasks = box.values.toList().cast<Task>();

                if (tasks.isEmpty) {
                  return Center(child: Text("No Tasks Yet 😎"));
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskTile(task: tasks[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

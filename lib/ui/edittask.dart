import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/models/task.dart';
import 'package:td2_flutter/repository/taskviewmodel.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late final TextEditingController _taskTitleController;

  @override
  void initState() {
    super.initState();
    _taskTitleController = TextEditingController(text: widget.task.title);
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _taskTitleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter task title';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue,
              ),
              onPressed: () {
                if (_taskTitleController.text.isNotEmpty) {
                  // Update the task with the new title
                  Task updatedTask = Task(
                    id: widget.task.id,
                    title: _taskTitleController.text,
                    tags: List.from(widget.task.tags),
                    nbhours: widget.task.nbhours,
                    difficulty: widget.task.difficulty,
                    description: widget.task.description,
                  );
                  context.read<TaskViewModel>().updateTask(updatedTask);
                  Navigator.pop(context, updatedTask);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter task title'),
                    ),
                  );
                }
              },
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}

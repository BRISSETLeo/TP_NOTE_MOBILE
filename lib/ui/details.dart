import 'package:flutter/material.dart';
import 'package:td2_flutter/models/task.dart';
import 'package:td2_flutter/models/todos.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("${task.title} ${task.id} ${task.tags} ${task.description} ${task.difficulty}")
      ),
    );
  }
}

class DetailScreenTodo extends StatelessWidget {
  const DetailScreenTodo({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("${todo.title} ${todo.id} ${todo.completed}")
      ),
    );
  }
}
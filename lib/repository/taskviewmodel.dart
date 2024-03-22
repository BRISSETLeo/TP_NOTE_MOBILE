import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier{
  late List<Task> liste;
  TaskViewModel(){
    liste=[];
  }
  void addTask(Task task){
    liste.add(task);
    notifyListeners();
  }
  void removeTask(Task task){
    liste.remove(task);
    notifyListeners();
  }
  void generateTasks(){
    liste = Task.generateTask(50);
    notifyListeners();
  }

  void updateTask(Task modifiedTask){
    for(int i=0;i<liste.length;i++){
      if(liste[i].id==modifiedTask.id){
        liste[i]=modifiedTask;
        break;
      }
    }
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Task.dart';
import 'Enums.dart';
import 'main.dart';
import 'TaskBox.dart';

class Controller{
  List<TaskBox> taskBoxes = [
    TaskBox(
        id: global_id++,
        task: new Task(
          title: "AHoj",
          description: "",
          type: "todo",
        )

    ),
    TaskBox(
        id: global_id++,
        task: new Task(
          title: "Svete",
          description: "Meow",
          type: "todo",
        )
    ),
    TaskBox(
        id: global_id++,
        task: new Task(
          title: "Haf",
          description: "Meow",
          type: "asap",
        )
    ),
    TaskBox(
        id: global_id++,
        task: new Task(
          title: "Maybe",
          description: "Meow",
          type: "maybe",
        )
    ),
  ];

  void Restore(int id)
  {
    taskBoxes.where((item) => item.id == id).first.task.state = States.active;
  }

  void AddTask(Task task)
  {
    var temp =  new TaskBox(
      id: global_id++,
      task: task,
    );
    taskBoxes.add(temp);
  }
  void MarkDone(int id)
  {
    taskBoxes.where((item) => item.id == id).first.task.state = States.done;
  }
  void KillTask(int id)
  {
    taskBoxes.removeWhere((item) => item.id == id);
  }

  void RemoveTask(int id)
  {
    taskBoxes.where((item) => item.id == id).first.task.state = States.deleted;
  }

  /**
   * Deletes all tasks with state or type == stateOrType
   */
  void DeleteAll(String stateOrType)
  {
    taskBoxes.removeWhere((item) => item.task.type == stateOrType || item.task.state == stateOrType);
  }

  List<TaskBox> GetList(String type)
  {
    return taskBoxes.where((item) => item.task.type == type && item.task.state == States.active).toList();
  }

  List<TaskBox> GetListByState(String state)
  {
    return taskBoxes.where((item) => item.task.state == state).toList();
  }
}

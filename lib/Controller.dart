import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Task.dart';
import 'Enums.dart';
import 'main.dart';
import 'TaskBox.dart';

class Controller{
  List<TaskBox> taskBoxes = new List<TaskBox>();
  static int global_id = 0;

  Controller()
  {
    getGlobalId();
    loadData();
  }

  void getGlobalId() async
  {
    final prefs = await SharedPreferences.getInstance();
    global_id = prefs.getInt("global_id") ?? 0;
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    for(var i = 0; i < global_id; i++)
      {
        var temp = new TaskBox();
        temp.task = new Task();
        temp.id = i;
        temp.task.title = prefs.getString(i.toString()+"title");
        temp.task.description = prefs.getString(i.toString()+"descr") ?? "";
        temp.task.type = prefs.getString(i.toString()+"type");
        String date = prefs.getString(i.toString()+"date");
        temp.task.date = date == null ? null : DateTime.parse(date);
        temp.task.state = prefs.getString(i.toString()+"state");
        taskBoxes.add(temp);
      }
    viewController.Refresh(Types.todo);
  }

  void saveData() async
  {
   final prefs = await SharedPreferences.getInstance();
   for(var tBox in taskBoxes)
     {
       prefs.setString(tBox.id.toString()+"title", tBox.task.title);
       prefs.setString(tBox.id.toString()+"descr", tBox.task.description);
       prefs.setString(tBox.id.toString()+"type", tBox.task.type);
       tBox.task.date == null ? null : prefs.setString(tBox.id.toString()+"date", tBox.task.date.toIso8601String());
       prefs.setString(tBox.id.toString()+"state", tBox.task.state);
     }
      prefs.setInt("global_id", global_id);
  }
  /* = [
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
  ];*/




  void Restore(int id)
  {
    taskBoxes.where((item) => item.id == id).first.task.state = States.active;
  }

  void AddTask(Task task) async
  {
    /*final pref = await SharedPreferences.getInstance();
    pref.se*/
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
    //NOTE: pokud chceme kos, zde nastavit state na deleted
    taskBoxes.where((item) => item.id == id).first.task.state = States.deleted;
    //taskBoxes.removeWhere((item) => item.id == id);
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

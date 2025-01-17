

/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Daniel Bubenicek (xbuben05), Jan Beran (xberan43)
 * Perzistentni ukladani vyhradne xberan43
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/Projects/Project.dart';
import 'package:itu/Projects/ProjectBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Task.dart';
import 'Enums.dart';
import 'main.dart';
import 'TaskBox.dart';

int numberOfFinished = 0;
int numberOfDeleted = 0;

class Controller{
  List<TaskBox> taskBoxes = new List<TaskBox>();
  List<ProjectBox> projectBoxes = new List<ProjectBox>();
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

  List<TaskBox> GetTasksByProject(String project_name)
  {
    return taskBoxes.where((item) => item.task.project == project_name).toList();
  }

  List<String> GetProjectNames()
  {
    //todo
    return ["none", "this", "is", "sample"];
  }

  void KillProject(int id, String project_name)
  {
    List<int> ids = new List();
   for(var tBox in taskBoxes)
     {
       if(tBox.task.project == project_name)
         {
           ids.add(tBox.id);
         }
     }
   for(int id in ids)
     {
       KillTask(id);
     }

    projectBoxes.removeWhere((item) => item.id == id);
    RemoveProjectFromPersistent(id);
  }
  void RemoveProjectFromPersistent(int id) async
  {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(id.toString()+"projectTitle");
    prefs.remove(id.toString()+"projectState");
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    for(var i = 0; i < global_id; i++)
      {
        var temp = new TaskBox();
        temp.task = new Task();
        temp.id = i;
        if(prefs.getString(i.toString()+"title") == null)
          {
            continue; //element deleted
          }
        temp.task.title = prefs.getString(i.toString()+"title");
        temp.task.description = prefs.getString(i.toString()+"descr") ?? "";
        temp.task.type = prefs.getString(i.toString()+"type");
        String date = prefs.getString(i.toString()+"date");
        temp.task.date = date == null ? null : DateTime.parse(date);
        temp.task.state = prefs.getString(i.toString()+"state");
        temp.task.project = prefs.get(i.toString()+"project");
        taskBoxes.add(temp);
      }
    for(var i = 0; i < global_id; i++)
    {
      var temp = new ProjectBox();
      temp.project = new Project();
      temp.id = i;
      if(prefs.getString(i.toString()+"projectTitle") == null)
      {
        continue; //element deleted
      }
      temp.project.title = prefs.getString(i.toString()+"projectTitle");
      temp.project.state = prefs.getString(i.toString()+"projectState");
      projectBoxes.add(temp);
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
       prefs.setString(tBox.id.toString()+"project", tBox.task.project);
       tBox.task.date == null ? null : prefs.setString(tBox.id.toString()+"date", tBox.task.date.toIso8601String());
       prefs.setString(tBox.id.toString()+"state", tBox.task.state);
     }
   for(var pBox in projectBoxes)
     {
       prefs.setString(pBox.id.toString()+"projectTitle", pBox.project.title);
       prefs.setString(pBox.id.toString()+"projectState", pBox.project.state);
     }
      prefs.setInt("global_id", global_id);
  }


  void Update(int id, Task task)
  {
    Task newtask = new Task();
    newtask.title = task.title;
    newtask.description = task.description;
    newtask.type = task.type;
    newtask.state = task.state;
    newtask.date = task.date;

    TaskBox newTaskbox = new TaskBox(id: id, task: newtask);
    KillTask(id);
    taskBoxes.add(newTaskbox);
    //taskBoxes.where((item) => item.id == id).first.task = task;
  }

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
    numberOfFinished++;
    taskBoxes.where((item) => item.id == id).first.task.state = States.done;
  }

  void KillTask(int id)
  {
    taskBoxes.removeWhere((item) => item.id == id);
  }

  void RemoveFromPersistent(int id) async
  {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(id.toString()+"title");
    prefs.remove(id.toString()+"descr");
    prefs.remove(id.toString()+"type");
    taskBoxes.where((item) => item.id == id).first == null ? null : prefs.remove(id.toString()+"date");
    prefs.remove(id.toString()+"state");
  }

  void RemoveTask(int id)
  {
    numberOfDeleted++;
    taskBoxes.where((item) => item.id == id).first.task.state = States.deleted;
  }

  /**
   * Deletes all tasks with state or type == stateOrType
   * changelog: Berry - call removefrompersistent to accept the deletion also in persistent data storage
   */
  void DeleteAll(String stateOrType)
  {
    var toKill = taskBoxes.where((item) => item.task.type == stateOrType || item.task.state == stateOrType);
    for(var item in toKill)
      {
        numberOfDeleted++;
        RemoveFromPersistent(item.id);
      }

    taskBoxes.removeWhere((item) => item.task.type == stateOrType || item.task.state == stateOrType);
  }

  List<ProjectBox> GetListProjects() {
    var ret = projectBoxes.where((item) => item.project.state == States.active).toList();
    ret.sort((a,b) => b.id.compareTo(a.id));
    return ret;
  }

  List<TaskBox> GetList(String type)
  {
    var ret = taskBoxes.where((item) => item.task.type == type && item.task.state == States.active).toList();
    ret.sort((a, b) => b.id.compareTo(a.id));
    return ret;
  }

  List<TaskBox> GetListByState(String state)
  {
    return taskBoxes.where((item) => item.task.state == state).toList();
  }

  void AddProject(Project project) {
    var temp =  new ProjectBox(
      id: global_id++,
      project: project,
    );
    projectBoxes.add(temp);
  }

  /*void AddTaskToProject(Task task, Project project) {
    var temp =  new TaskBox(
      id: global_id++,
      task: task,
    );
    project.tasks.add(temp);
    taskBoxes.add(temp);
    return;
  }*/
  /*
  List<TaskBox> GetTasksInProject(Project project) {
    return project.tasks.where((item) => item.task.state == States.active).toList();
  }

  void AddTestTasksToProject(Project project) { //only for debug
    AddTaskToProject(new Task(title: "test1",description: ""), project);
    AddTaskToProject(new Task(title: "test2",description: ""), project);
  }*/

  List<ProjectBox> GetProjects() {
    return projectBoxes;
  }
 /* List<Task> GetThreeUndoneTasksInProject(Project project) {
    ge
  }*/

}

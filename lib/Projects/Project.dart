import 'package:flutter/cupertino.dart';
import 'package:itu/Task.dart';
import 'package:itu/TaskBox.dart';

class Project{
  Project({Key key, this.tasks, this.title, this.state = "active"});
  List<TaskBox> tasks = new List<TaskBox>();
  String title;
  String state;// = "active"; //or deleted, done...
}
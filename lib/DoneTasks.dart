import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'NewTask.dart';
import 'main.dart';
import 'TaskBox.dart';
import 'Enums.dart';

class DoneTasks extends StatefulWidget{
  @override
  DoneTasksView createState() => DoneTasksView();
}

class DoneTasksView extends State<DoneTasks>{

  List<TaskBox> tasks = controller.GetListByState(States.done);
/*
  void refresh()
  {
    setState(() {
      todos = controller.GetList(States.done);
    });
  }
*/
  @override
  Widget build(BuildContext context){
    //currentColor = AppBarColor.todoColor;
    return ListView(children: tasks,);
  }

}

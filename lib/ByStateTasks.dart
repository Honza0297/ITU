/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Daniel Bubenicek (xbuben05)
 */

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

class ByStateTasks extends StatefulWidget{
  const ByStateTasks({Key key, this.state}) : super(key: key);

  final String state;
  @override
  ByStateTasksView createState() => viewController.NewByStateTasksView(state);
}

class ByStateTasksView extends State<ByStateTasks>{
  ByStateTasksView(this.state){
    tasks = controller.GetListByState(state);
  }

  List<TaskBox> tasks;
  final String state;

  void refresh()
  {
    setState(() {
      tasks = controller.GetListByState(state);
    });
  }

  @override
  Widget build(BuildContext context){
    //currentColor = AppBarColor.todoColor;
    return ListView(children: tasks,);
  }

}

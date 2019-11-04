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

class AsapTab extends StatefulWidget{
  @override
  AsapView createState() => viewController.asapView;
}

class AsapView extends State<TodoTab>{
  List<TaskBox> asaps = controller.GetList("asap");

  void refresh()
  {
    setState(() {
      asaps = controller.GetList("asap");
    });
  }

  @override
  Widget build(BuildContext context){
    return ListView(children: asaps,);
  }

}
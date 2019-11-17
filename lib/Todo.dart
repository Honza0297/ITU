import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/Task.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'NewTask.dart';
import 'main.dart';
import 'TaskBox.dart';
import 'Enums.dart';

class TodoTab extends StatefulWidget{
  @override
  TodoView createState() => viewController.NewTodoView();
}

class TodoView extends State<TodoTab>{
  List<TaskBox> todos = controller.GetList(Types.todo);

  void refresh()
  {
    setState(() {
      todos = controller.GetList(Types.todo);
    });
  }

  @override
  Widget build(BuildContext context){
    //currentColor = AppBarColor.todoColor;
    return ListView(children: todos,);
  }

}

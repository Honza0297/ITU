import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/ByStateTasks.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'Task.dart';
import 'main.dart';
import 'Enums.dart';


class TasksByStateScreen extends StatefulWidget {
  TasksByStateScreen(this.state, {Key key, Color color}): super(key: key){
    this.col = color;
  }
  Color col;
  final String state;

  @override
  _TasksByStateScreenState createState() => _TasksByStateScreenState(state);
}

class _TasksByStateScreenState extends State<TasksByStateScreen> {
  _TasksByStateScreenState(this.state);

  final String state;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.col,
        title: Text(state == States.done ? "Done tasks" : "Bin"),
        //automaticallyImplyLeading: false, //asi nepotrebne
        leading:  IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: ByStateTasks(state: state),
    );
  }
}
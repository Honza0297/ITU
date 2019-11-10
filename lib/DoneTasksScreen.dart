import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'Task.dart';
import 'main.dart';
import 'Enums.dart';


class DoneTasksScreen extends StatefulWidget {
  DoneTasksScreen({Key key, Color color}): super(key: key){
    this.col = color;
  }
  Color col;

  @override
  _DoneTasksScreenState createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.col,
        title: Text("Done tasks"),
        //automaticallyImplyLeading: false, //asi nepotrebne
        leading:  IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white, ),
            onPressed: (){
                Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: controller.GetListByState(States.done),
      ),
    );
  }
}
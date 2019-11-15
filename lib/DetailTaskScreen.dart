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


class DetailTaskScreen extends StatefulWidget {
  DetailTaskScreen({Key key, Color color}): super(key: key){
    this.col = color;
  }
  Color col;

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  _DetailTaskScreenState();


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.col,
        title: Text("Task details??"),
        leading:  IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
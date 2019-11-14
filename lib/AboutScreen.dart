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


class AboutScreen extends StatefulWidget {
  AboutScreen({Key key, Color color}): super(key: key){
    this.col = color;
  }
  Color col;

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  _AboutScreenState();


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.col,
        title: Text("About"),
        leading:  IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Text("BigDuck Tasks/To-Do - thats the question. Great app for storing your tasks according to getting things done method with no persistent memory. By Berry, Denny and in the future maybe also Carbik."),
    );
  }
}
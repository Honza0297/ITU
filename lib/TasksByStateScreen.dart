/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Daniel Bubenicek (xbuben05)
 */

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
        actions: <Widget>[
          FlatButton(
              child: Text(state == States.done ? " Empty done tasks" : "Empty bin"),
              onPressed: (){
                setState(() {
                  showAlertDialog(context, state);
                });
              },
          ),
        ],
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

void showAlertDialog(BuildContext context, String state) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Delete"),
    onPressed:  () {
      controller.DeleteAll(state);
      viewController.Refresh(state);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(state == States.done ? "Empty done tasks" : "Empty bin"),
    content: Text(state == States.done ? "Do you really want to permanently delete all tasks marked as done?" : "Do you really want to permanently delete all tasks from bin?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Jan Carba (xcarba00)
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/NewTask.dart';
import 'package:itu/Projects/Project.dart';
import '../Controller.dart';
import '../TaskBox.dart';
import '../ViewController.dart';
import '../Todo.dart';
import '../Task.dart';
import '../main.dart';
import '../Enums.dart';



class NewProject extends StatefulWidget {
  NewProject({Key key, int index}): super(key: key){}

  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {

  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 1, 1, 3);

  String title = "";

  @override
  void initState(){
  }

  @override
  void dispose(){
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Project"),
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
              if (title == "") {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        "You have to fill \"Title\" field"
                      ),
                    );
                  }
                );
              } else {
                controller.AddProject(new Project(title: title, tasks: new List<TaskBox>()));
                try {
                  viewController.Refresh("project");
                } catch (e) {}
                  Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: <Widget>[
          Padding(
            padding: myPadding,
            child: TextField(
              autofocus: true,
              onChanged: (String str){title = str;},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Title"
              ),

            ),
          ),
        ],
      ),
      );
  }
}


class MyToggleButtons extends StatefulWidget{

  @override
  MyToggleButtonsState createState() => MyToggleButtonsState();
}

class MyToggleButtonsState extends State<MyToggleButtons>{
  List<bool> isSelected;
  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 5, 1, 10);
  final double height = 60;


  @override
  void initState(){
  }

  @override
  Widget build(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(1, 3, 0, 8),
        child: ToggleButtons(
          children: <Widget>[],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: isSelected,
        ),
      ),
    );
  }
}


class MyButton extends StatelessWidget {
  MyButton({Key key, this.text, this.color, this.icon}) :
        super(key: key);


  final String text;
  final EdgeInsets myPadding = EdgeInsets.all(5.0);
  final Color color;
  final IconData icon;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 4),
      child: Column(
          children: <Widget>[
            Icon(icon, color: color, ),
            Text(text, ),//style: TextStyle(color: color)),
          ]),
    );
  }
}

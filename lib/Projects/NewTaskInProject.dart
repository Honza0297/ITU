/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Jan Carba (xcarba00)
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/Projects/DetailProjectScreen.dart';
import 'package:itu/Projects/Project.dart';
import '../Controller.dart';
import '../ViewController.dart';
import '../Todo.dart';
import '../Task.dart';
import '../main.dart';
import '../Enums.dart';


String newTaskType;
TimeOfDay lastPickedTime = TimeOfDay.fromDateTime(DateTime.utc(2019, 1,1,15,0));

class TypeData {
  TypeData(String type){
    this.type = type;
  }

  String type;
}


class NewTaskInProject extends StatefulWidget {
  NewTaskInProject({Key key, int index, Project project}): super(key: key){
    switch(index){
      case 0:
        newTaskType = Types.todo;
        break;
      case 1:
        newTaskType = Types.asap;
        break;
      case 3:
        newTaskType = Types.maybe;
        break;
    }
  }
  Project project;
  Color col;
  //String type;
  //static TypeData typeClass = new TypeData(type);

  @override
  _NewTaskInProjectState createState() => _NewTaskInProjectState();
}

class _NewTaskInProjectState extends State<NewTaskInProject> {
  String title = "";
  String text = "";
  DateTime dateTimeNotification;
  final dtPickerController = new TextEditingController();

  final double buttonHeight = 60;

  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 1, 1, 3);

  MyToggleButtons buttons = MyToggleButtons();


  @override
  void initState(){
    dateTimeNotification = null;
  }

  RemoveReminder() {
    setState(() {
      dateTimeNotification = null;
      dtPickerController.text = "";
    });
  }

  @override
  void dispose(){
    dtPickerController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.col,
        title: Text("New task"),
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
                controller.AddTaskToProject(new Task(title: title, description: text, type: newTaskType, ), actualProject);
                viewController.Refresh(newTaskType);
                Navigator.pop(context);
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
          Padding(
            padding: myPadding,
            child: TextField(
              onChanged: (String str){text = str;},
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description"
              ),
            ),
          ),
          Padding(
            padding: myPadding,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: dtPickerController,
                    onTap: () async {
                      DateTime now = DateTime.now();
                      DateTime date = await showDatePicker(
                        context: context,
                        firstDate: now,
                        initialDate: now,
                        lastDate: DateTime(2030),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: child,
                          );
                        },
                      );
                      if(date == null)
                        return;
                      var $time = await showTimePicker(
                          context: context,
                          initialTime: lastPickedTime,
                          builder: (BuildContext context, Widget child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                              child: Theme(
                                data: ThemeData.dark(),
                                child: child,
                              ),
                            );
                          }
                      );
                      if($time == null)
                        return;

                      lastPickedTime = $time;
                      setState(() {
                        dateTimeNotification = DateTime(date.year, date.month, date.day, lastPickedTime.hour, lastPickedTime.minute);
                      });
                      dtPickerController.text = DateFormat('dd. MM. yyyy - kk:mm').format(dateTimeNotification);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Add reminder"
                    ),
                  ),
                ),
                dateTimeNotification != null ? Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 1, 1),
                  child: IconButton(
                    icon: new Icon(Icons.delete),
                    onPressed: () => RemoveReminder(),
                  ),
                ) : Container(),//just an empty widget (null is not working)
              ],
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
    isSelected = [false, false, false, false];
    if(newTaskType == Types.todo)
      isSelected[0] = true;
    else if(newTaskType == Types.asap)
      isSelected[1] = true;
    else if(newTaskType == Types.maybe)
      isSelected[2] = true;
    else
      isSelected[3] = true;
    super.initState();
  }

  String GetType(){
    String type;
    if(isSelected[0] == true)
      type = Types.todo;
    else if(isSelected[1] == true)
      type = Types.asap;
    else
      type = Types.maybe;
    newTaskType = type;
  }

  @override
  Widget build(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(1, 3, 0, 8),
        child: ToggleButtons(
          children: <Widget>[
            MyButton(
              text: "Todo",
              color: colors[0],
              icon: Icons.format_align_left,
            ),
            MyButton(
              text: "Asap",
              color: colors[1],
              icon: Icons.priority_high,
            ),
            MyButton(
              text: "Maybe",
              color: colors[3],
              icon: Icons.not_listed_location,
            ),
            MyButton(
              text: "Project",
              color: colors[4],
              icon: Icons.table_chart,
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
              GetType();
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

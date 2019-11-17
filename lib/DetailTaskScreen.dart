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



TimeOfDay lastPickedTime = TimeOfDay.fromDateTime(DateTime.utc(2019, 1,1,15,0));



String global_type;
String old_type;

class DetailTaskScreen extends StatefulWidget {
  DetailTaskScreen({this.task, this.id})
  {
    global_type = task.type;
    old_type = task.type;
  }
  Color col;
  Task task;
  int id;

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState(this.task);
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  _DetailTaskScreenState(this.task);

  Task task;
  var dtPickerController = new TextEditingController();
  final double buttonHeight = 60;
  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 1, 1, 3);
  MyToggleButtons buttons = MyToggleButtons();
  DateTime dateTimeNotification;

  @override
  void initState(){
    dtPickerController.text = this.widget.task.date == null ? "" :  DateFormat('dd. MM. yyyy - kk:mm').format(this.widget.task.date);
    dateTimeNotification = this.widget.task.date;
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
        title: Text(this.widget.task.title),
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
              if(this.widget.task.title == "" && this.widget.task.description == "") {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            "You have to fill at least one of \"Title\" and \"Text\" fields!"),
                      );
                    }
                );
              }
              else
              {
                this.widget.task.type = global_type;
                this.widget.task.date = dateTimeNotification;
                controller.Update(this.widget.id, this.widget.task);
                try
                {
                  viewController.Refresh(old_type);
                  viewController.Refresh(global_type);
                }
                catch(e) {
                }
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
          buttons,
          Padding(
            padding: myPadding,
            child: TextFormField(
              initialValue: this.widget.task.title,
              onChanged: (String str){this.widget.task.title = str;},
              style: TextStyle(
                fontSize: 24,
              ),
              decoration: InputDecoration(
                  border: null,
                  labelText: "Title"
              ),
            ),
          ),
          Padding(
            padding: myPadding,
            child: TextFormField(
              initialValue: this.widget.task.description,
              onChanged: (String str){this.widget.task.description = str;},
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: null,
                  labelText: "Description"
              ),
            ),
          ),
          Padding(
            padding: myPadding,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextFormField(
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
                        border: null,
                        labelText: "Reminder"
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

  MyToggleButtons();


  @override
  MyToggleButtonsState createState() => MyToggleButtonsState();
}

class MyToggleButtonsState extends State<MyToggleButtons>{
  MyToggleButtonsState();
  List<bool> isSelected;
  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 5, 1, 10);
  final double height = 60;


  @override
  void initState(){
    isSelected = [false, false, false, false];
    if(global_type == Types.todo)
      isSelected[0] = true;
    else if(global_type == Types.asap)
      isSelected[1] = true;
    else if(global_type == Types.maybe)
      isSelected[2] = true;
    else
      isSelected[3] = true;
    super.initState();
  }

  void GetType(){
    String type;
    if(isSelected[0] == true)
      type = Types.todo;
    else if(isSelected[1] == true)
      type = Types.asap;
    else
      type = Types.maybe;
    global_type = type;
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

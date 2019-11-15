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

class TypeData {

  //TypeData(this.type);

  String type = Types.todo;
}

class NewTask extends StatefulWidget {
  NewTask({Key key, Color color}): super(key: key){
    this.col = color;
  }
  Color col;

  static TypeData typeClass = new TypeData();

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String title = "";
  String text = "";
  DateTime dateTimeNotification;
  final dtPickerController = new TextEditingController();

  final double buttonHeight = 60;

  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 1, 1, 3);

  MyToggleButtons buttons = MyToggleButtons(NewTask.typeClass);

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
              if(text == "" && title == "") {
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
                controller.AddTask(new Task(title: title, description: text, type: NewTask.typeClass.type, date: dateTimeNotification));
                try
                {
                  viewController.Refresh(NewTask.typeClass.type);
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
                  labelText: "Text"
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

  MyToggleButtons(this.type);
  TypeData type;

 /* MyToggleButtonsState state = MyToggleButtonsState();

  MyToggleButtonsState GetState()
  {
    state = MyToggleButtonsState();
    return state;
  }
*/
  @override
  MyToggleButtonsState createState() => MyToggleButtonsState(type);
}

class MyToggleButtonsState extends State<MyToggleButtons>{
  MyToggleButtonsState(this.type){
    type.type = Types.todo;
  }
  TypeData type;
  List<bool> isSelected;
  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 5, 1, 10);
  final double height = 60;


  @override
  void initState(){
    isSelected = [true, false, false, false];
    super.initState();
  }

  String GetType(){
    if(isSelected[0] == true)
      return Types.todo;
    else if(isSelected[1] == true)
      return Types.asap;
    else
      return Types.maybe;
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
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
              type.type = GetType();
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
  final EdgeInsets myPadding = EdgeInsets.all(6.0);
  final Color color;
  final IconData icon;

  Widget build(BuildContext context) {
    return Padding(
      padding: myPadding,
      child: Column(
          children: <Widget>[
            Icon(icon, color: color, ),
            Text(text, ),//style: TextStyle(color: color)),
          ]),
    );
  }
}

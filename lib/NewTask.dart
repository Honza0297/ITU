import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'Task.dart';
import 'main.dart';
import 'Enums.dart';

class TypeData {

  //TypeData(this.type);

  String type = Types.todo;
}

class NewTask extends StatelessWidget {
  Color col;
  NewTask({Key key, Color color}): super(key: key){
    this.col = color;
  }

  static TypeData typeClass = new TypeData();

  String title = "";
  String text = "";

  DateTime time;
  //String type;
  final double buttonHeight = 60;
  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 5, 1, 10);
  MyToggleButtons buttons = MyToggleButtons(typeClass);


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.col,
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
                controller.AddTask(new Task(title: title, description: text, type: typeClass.type /*buttons.state.GetType()*/));
                try
                {
                  viewController.Refresh(typeClass.type/*buttons.state.GetType()*/);
                }
                catch(e)
              {

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
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyButton(
                text: "Todo",
              ),
              MyButton(
                text: "ASAP",
              ),
              MyButton(
                text: "Maybe",
              ),
              MyButton(
                text: "Project",
              ),
            ],
          ),*/
          buttons,
          TextField(
            onChanged: (String str){title = str;},
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Title"
            ),
          ),
          TextField(
            onChanged: (String str){text = str;},
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Text"
            ),
          ),
          TextField(
            onTap: (){
              DateTime now = DateTime.now();
              Future<DateTime> selectedDate = showDatePicker(
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
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Add reminder"
            ),
          ),
        ],
      ),
    );
  }
}


class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ToggleButtons(
              borderColor: Colors.black,
              fillColor: Colors.grey,
              borderWidth: 2,
              selectedBorderColor: Colors.black,
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Open 24 Hours',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Custom Hours',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    if (i == index) {
                      isSelected[i] = true;
                    } else {
                      isSelected[i] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
            ),
          ],
        ),
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
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Icon(Icons.format_align_left, color: colors[0], ),
            ),
            Icon(Icons.priority_high, color: colors[1] ),
            Icon(Icons.not_listed_location, color: colors[3] ),
            Icon(Icons.table_chart, color: colors[4] )
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
  MyButton({Key key, this.text}) :
        super(key: key);


  final String text;
  final double height = 60;
  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 5, 1, 10);


  Widget build(BuildContext context) {
    return ButtonTheme(
      height: height,
      child: Padding(
        padding: myPadding,
        child: RaisedButton(
          onPressed: (){},
          child: Text("text"),
        ),
      ),
    );
  }
}

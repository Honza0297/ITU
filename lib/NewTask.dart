import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'Task.dart';
import 'main.dart';
import 'TaskBox.dart';

class NewTask extends StatelessWidget {
  NewTask({Key key,this.todos}) :
        super(key: key);
  final List<TaskBox> todos;
  String title = "";
  String text = "";
  DateTime time;
  String type;
  final double buttonHeight = 60;
  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 5, 1, 10);

  Future pokus(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text("pes"),
          );
        }
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                controller.AddTask(new Task(title: title, description: text, type: "todo"));
                viewController.Refresh("todo");
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                height: buttonHeight,
                child: Padding(
                  padding: myPadding,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("bla"),
                  ),
                ),
              ),
              ButtonTheme(
                height: buttonHeight,
                child: Padding(
                  padding: myPadding,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("bla"),
                  ),
                ),
              ),
              ButtonTheme(
                height: buttonHeight,
                child: Padding(
                  padding: myPadding,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("bla"),
                  ),
                ),
              ),
              ButtonTheme(
                height: buttonHeight,
                child: Padding(
                  padding: myPadding,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("bla"),
                  ),
                ),
              ),
            ],
          ),
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
              Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
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

          /*FlatButton(
              child: Text(
                  "buttonek"
              ),
            ),
            RaisedButton(
              onPressed: (){},
              child: Text(
                  "Add reminder"
              ),
            )
            */

        ],
      ),
    );
  }
}

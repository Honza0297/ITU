import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'NewTask.dart';
import 'main.dart';
import 'Task.dart';
import 'Enums.dart';

class TaskBox extends StatelessWidget {
  TaskBox({Key key, this.id,  this.task}) :
        super(key: key);
  int id;
  Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 120,
        child: Card(
          child: Slidable(
            key: Key((this.id).toString()),
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 3, child:
                Padding(padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,

                    child: Row(children: <Widget>[Expanded(child: Text(
                        this.task.title, textScaleFactor: 1.2, style:
                          TextStyle(fontWeight: FontWeight.bold,)
                    )),
                    Text(this.task.date == null ? "" : getNiceDate(this.task.date), textAlign: TextAlign.right,)], )
                    ,),)
                ),
                Expanded(flex: 5, child:
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                    Text(
                        this.task.description,
                        style: TextStyle(
                            color: Colors.grey
                        )
                    ),),
                )
                ),

              ],), actions: <Widget>[ this.task.state == States.active ?
          IconSlideAction(
            color: Colors.green,
            icon: Icons.done,
            onTap: null,
          )
          :
          IconSlideAction(
            color: Colors.blue,
            icon: Icons.refresh,
            onTap: null,
          ),
          ],
            secondaryActions: <Widget>[
              IconSlideAction(
                color: Colors.red,
                icon: Icons.delete,
                onTap: null,
              ),
            ],
            dismissal: SlidableDismissal(
              dismissThresholds: <SlideActionType, double>{
                SlideActionType.primary : 0.3,
                SlideActionType.secondary: 0.3
              },
              child: SlidableDrawerDismissal(),
              onDismissed: (action){
                switch(action)
                {
                  case SlideActionType.primary:
                    if (this.task.state == States.done)
                      {
                        controller.Restore(this.id);
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Task Undoned.")));
                        viewController.Refresh(States.done);
                      }
                    else if (this.task.state == States.deleted)
                    {
                      controller.Restore(this.id);
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Task Restored.")));
                      viewController.Refresh(States.deleted);
                    }
                    else
                      {
                        controller.MarkDone(this.id);
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Task marked as Done.")));
                      }
                    break;
                  case SlideActionType.secondary:
                    if(this.task.state == States.active)
                      {
                        controller.RemoveTask(this.id);
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Task marked as Deleted.")));
                      }
                    else
                      {
                        controller.KillTask(this.id);
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Task deleted permanently.")));
                        viewController.Refresh(States.deleted);
                        viewController.Refresh(States.done);
                      }
                    break;
                  default:
                }
                try {
                  viewController.Refresh(this.task.type);
                }
                catch(e){}
              },
            ),
          ),




        )
    );
  }

  getNiceDate(DateTime date) {
    String sd = date.toIso8601String();
    date = DateTime.parse(sd);
    return date.day.toString() +
        "-" + date.month.toString() +
        "-" + date.year.toString() +
        " " + date.hour.toString() +
        "." + (date.minute.toInt()==0 ? "00" : date.minute.toString());
  }
}
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
            actionExtentRatio: 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 3, child:
                Padding(padding: EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,

                    child:
                    Text(
                        this.task.title, textScaleFactor: 1.2, style: TextStyle(
                      fontWeight: FontWeight.bold,

                    )
                    ),),)
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

              ],), actions: <Widget>[ this.task.state != States.done ?
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
          )
            ,
          ],
            secondaryActions: <Widget>[
              IconSlideAction(
                color: Colors.red,
                icon: Icons.delete,
                onTap: null,
              ),
            ],
            dismissal: SlidableDismissal(
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
                    else
                      {
                        controller.MarkDone(this.id);
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Task marked as Done.")));
                      }
                    break;
                  case SlideActionType.secondary:
                    controller.RemoveTask(this.id);
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Task marked as Deleted.")));
                    break;
                  default:
                }
                viewController.Refresh(this.task.type);
              },
            ),
          ),




        )
    );
  }
}
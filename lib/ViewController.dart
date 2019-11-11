import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/ByStateTasks.dart';
import 'package:itu/TasksByStateScreen.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'NewTask.dart';
import 'Asap.dart';
import 'Maybe.dart';
import 'Enums.dart';

class ViewController
{
  ViewController({Key key,});
  var todoView = new TodoView();
  var asapView = new AsapView();
  var maybeView = new MaybeView();
  var doneView;// = new DoneTasksView();

  void Refresh(String typeOrState)
  {
    switch(typeOrState)
    {
      case States.done:
      case States.deleted:
        doneView.refresh();
        break;
      case Types.todo:
        todoView.refresh();
        break;
      case Types.asap:
        asapView.refresh();
        break;
      case Types.maybe:
        maybeView.refresh();
        break;
      default:
    }
  }

  TodoView NewTodoView()
  {
    todoView = new TodoView();
    return todoView;
  }

  AsapView NewAsapView()
  {
    asapView = new AsapView();
    return asapView;
  }

  MaybeView NewMaybeView()
  {
    maybeView = new MaybeView();
    return maybeView;
  }

  ByStateTasksView NewDoneTaskView(String state)
  {
    doneView = new ByStateTasksView(state);
    return doneView;
  }

}
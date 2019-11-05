import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'NewTask.dart';
import 'Asap.dart';
import 'Maybe.dart';
import 'TaskBox.dart';

class ViewController
{
  ViewController({Key key,});
  var todoView = new TodoView();
  var asapView = new AsapView();
  var maybeView = new MaybeView();
  //var doneView = new DoneView();
  void Refresh(String type)
  {
    switch(type)
    {
      case "todo":
        todoView.refresh();
        break;
      case "asap":
        asapView.refresh();
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

}
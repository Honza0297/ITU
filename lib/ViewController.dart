import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/ByStateTasks.dart';
import 'package:itu/Projects/DetailProjectScreen.dart';
import 'package:itu/Projects/Project.dart';
import 'package:itu/Projects/Projects.dart';
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
  var projectView = new ProjectsView();
  List<DetailProjectScreenView> detailProjectViews = new List<DetailProjectScreenView>();
  var byStateView;

  void Refresh(String typeOrState)
  {
    switch(typeOrState)
    {
      case States.done:
      case States.deleted:
        byStateView.refresh();
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
      case Types.project:
        projectView.refresh();
        break;
      default:
    }
    for (int i = 0; i<detailProjectViews.length;i++) {
      try {
        detailProjectViews[i].refresh();
      } catch(e) {}
    }
  }

  void AddProjectScreenView(DetailProjectScreenView detailProjectScreenView) {
    detailProjectViews.add(detailProjectScreenView);
    return;
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

  ByStateTasksView NewByStateTasksView(String state)
  {
    byStateView = new ByStateTasksView(state);
    return byStateView;
  }

  ProjectsView NewProjectsView() {
    projectView = new ProjectsView();
    return projectView;
  }

}
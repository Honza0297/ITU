/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Daniel Bubenicek (xbuben05), Jan Beran (xberan43)
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'NewTask.dart';
import 'main.dart';
import 'TaskBox.dart';

class Task{
  Task({Key key, this.title, this.description, this.type, this.date, this.state = "active"});

  String title;
  String description;
  String type; //to-do, asap, maybe
  DateTime date;
  String state;// = "active"; //or deleted, done...
}

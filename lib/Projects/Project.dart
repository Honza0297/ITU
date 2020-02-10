/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Jan Carba (xcarba00)
 */

import 'package:flutter/cupertino.dart';
import 'package:itu/Task.dart';
import 'package:itu/TaskBox.dart';

class Project{
  Project({Key key, this.title, this.state = "active"});
  String title;
  String state;// = "active"; //or deleted, done...
}
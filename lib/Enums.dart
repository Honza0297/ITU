/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Daniel Bubenicek (xbuben05), Jan Beran (xberan43)
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Types
{
  static const String todo = "todo";
  static const String asap = "asap";
  static const String maybe = "maybe";
}

class States
{
  static const String done = "done";
  static const String active = "active";
  static const String deleted = "deleted";
}

List<Color> colors = [Colors.indigo[500], Colors.red[600],
  Colors.green[600], Colors.blueGrey[600].withBlue(160), Colors.yellow[700]];
List<Text> texts = [Text("Todo"), Text("Asap"), Text("Calendar"), Text("Maybe"), Text("Projects")];


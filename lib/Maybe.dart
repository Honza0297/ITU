/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Jan Beran (xberan43) - tabBar a vetsina ostatniho
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

class MaybeTab extends StatefulWidget{
  @override
  MaybeView createState() => viewController.NewMaybeView();
}

class MaybeView extends State<MaybeTab>{
  List<TaskBox> maybes = controller.GetList("maybe");

  void refresh()
  {
    setState(() {
      maybes = controller.GetList("maybe");
    });
  }

  @override
  Widget build(BuildContext context){
    return ListView(children: maybes,);
  }
}
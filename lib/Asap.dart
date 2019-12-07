/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Jan Beran (xberan43)
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/Enums.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'NewTask.dart';
import 'main.dart';
import 'TaskBox.dart';

class AsapTab extends StatefulWidget{
  @override
  AsapView createState() => viewController.NewAsapView();
}

class AsapView extends State<AsapTab>{
  List<TaskBox> asaps = controller.GetList(Types.asap);

  void refresh()
  {
    setState(() {
      asaps = controller.GetList(Types.asap);
    });
  }

  @override
  Widget build(BuildContext context){
    //currentColor = AppBarColor.asapColor;
    return ListView(children: asaps,);
  }
}
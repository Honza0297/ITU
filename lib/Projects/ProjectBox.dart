/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Jan Carba (xcarba00)
 */

import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/Projects/Project.dart';
import '../Controller.dart';
import '../ViewController.dart';
import '../Todo.dart';
import '../NewTask.dart';
import '../main.dart';
import '../Task.dart';
import '../Enums.dart';
import 'package:itu/DetailTaskScreen.dart';

import 'DetailProjectScreen.dart';

class ProjectBox extends StatelessWidget {
  ProjectBox({Key key, this.id, this.project}) :
        super(key: key);
  int id;
  Project project;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 120,
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProjectScreen(project: project,id: id,)));
      },
      child: Card(
          key: Key((this.id).toString()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Align(
                alignment: Alignment.topLeft,

                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(this.project.title,
                      style: TextStyle(fontWeight: FontWeight.bold),

                      )
                    ,)
                  ],
                ),

              ),
            ),
            )
          ],
          ),
        ),
      ),
    );
  }
}
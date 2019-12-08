/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru: Jan Carba (xcarba00)
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class CalendarTab extends StatefulWidget{
  @override
  CalendarView createState() => CalendarView();
}

class CalendarView extends State<CalendarTab>{

  @override
  Widget build(BuildContext context){
    return RaisedButton(
      onPressed: (){
          DeviceApps.openApp('com.google.android.calendar');
      },
      color: Color.fromRGBO(50, 50, 50, 0),
      child: Text(
          'Run calendar App',
      ),
    );
  }
}
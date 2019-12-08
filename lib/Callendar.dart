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
          DeviceApps.openApp('com.calendar.app');
      },
      color: Color.fromRGBO(50, 50, 50, 0),
      child: Text(
          'Run calendar App',
      ),
    );
  }
}
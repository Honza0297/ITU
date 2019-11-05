import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/Asap.dart';
import 'package:itu/Enums.dart';
import 'package:itu/Maybe.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'Asap.dart';
import 'Maybe.dart';
import 'NewTask.dart';

int global_id= 0;
Controller controller = new Controller();
Color currentColor = AppBarColor.todoColor;
var viewController = new ViewController();





void main() => runApp(MyApp());
/*
void main() {
  runApp(MaterialApp(
   // title: 'Navigation Basics',
    home: MyApp(),
  ));
}
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
          builder: (context) => Center(
            child: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.format_align_left, color: Colors.deepPurpleAccent,),),
                      Tab(icon: Icon(Icons.priority_high, color: Colors.red,)),
                      Tab(icon: Icon(Icons.calendar_today, color: Colors.green,)),
                      Tab(icon: Icon(Icons.not_listed_location, color: Colors.blueGrey)),
                      Tab(icon: Icon(Icons.table_chart, color: Colors.yellow,)),
                    ],
                  ),
                  title: Text('GTD - Lite'),
                  backgroundColor: currentColor,
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TodoTab(),
                    AsapTab(),
                    Icon(Icons.not_listed_location),
                    MaybeTab(),
                    Icon(Icons.directions_car),
                  ],
                ),
                floatingActionButton: FloatingActionButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewTask()),
                  );
                },
                  child: Icon(Icons.add,), backgroundColor: currentColor,),
              ),
            ),
          ),
        )
    );
  }
}





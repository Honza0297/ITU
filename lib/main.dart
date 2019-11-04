import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'NewTask.dart';

int global_id= 0;
Controller controller = new Controller();
var statetodo = new TodoView();




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
        color: Colors.blue[200],
        home: Builder(
          builder: (context) => Center(
            child: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(

                    labelColor: Colors.deepOrangeAccent,
                    tabs: [
                      Tab(icon: Icon(Icons.format_align_left, color: Colors.deepPurpleAccent,),),
                      Tab(icon: Icon(Icons.priority_high, color: Colors.red,)),
                      Tab(icon: Icon(Icons.calendar_today, color: Colors.green,)),
                      Tab(icon: Icon(Icons.not_listed_location, color: Colors.blueGrey)),
                      Tab(icon: Icon(Icons.table_chart, color: Colors.yellow,)),
                    ],
                  ),
                  title: Text('Tabs Demo'),
                  backgroundColor: Colors.blue[200],
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TodoTab(),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                    Icon(Icons.not_listed_location),
                    Icon(Icons.directions_car),
                  ],
                ),
                floatingActionButton: FloatingActionButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewTask()),
                  );
                },
                  child: Icon(Icons.add,), backgroundColor: Colors.grey,),
              ),
            ),
          ),
        )
    );
  }
}

var viewController = new ViewController();



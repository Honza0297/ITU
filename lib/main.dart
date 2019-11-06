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
var viewController = new ViewController();

void main() => runApp(BigDuckTasks());

class BigDuckTasks extends StatefulWidget {
  @override
  _BigDuckTasksState createState() => _BigDuckTasksState();
}

class _BigDuckTasksState extends State<BigDuckTasks> {
  Color color = colors[0];
  Text text = texts[0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
          builder: (context) => Center(
            child: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  leading: Image.asset('assets/BigDuckSimple.png'),
                  actions: <Widget>[
                    IconButton(icon:  Icon(Icons.menu, color: Colors.white,),
                    onPressed: (){
                     //TODO Carbik misto pro napojeni menu :)
                      },
                    )
                  ],
                  bottom: TabBar(
                    onTap: (index){
                      setState(() {
                        this.color = colors[index];
                        this.text = texts[index];
                      });
                    },
                    tabs: [
                      Tab(icon: Icon(Icons.format_align_left,),),
                      Tab(icon: Icon(Icons.priority_high,)),
                      Tab(icon: Icon(Icons.calendar_today, )),
                      Tab(icon: Icon(Icons.not_listed_location, )),
                      Tab(icon: Icon(Icons.table_chart, )),
                    ],
                  ),
                  title: this.text,
                  backgroundColor: this.color,
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TodoTab(),
                    AsapTab(),
                    Text("Calendar"),
                    MaybeTab(),
                    Icon(Icons.directions_car),
                  ],
                ),
                floatingActionButton: FloatingActionButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewTask(color: this.color)),
                  );
                },
                  child: Icon(Icons.add,), backgroundColor: this.color),
              ),
            ),
          ),
        )
    );
  }
}





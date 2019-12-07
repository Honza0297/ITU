/**
 * Projekt do predmetu ITU na FIT VUT v Brne - tym xberan43, xbuben05, xcarba00
 * Autori tohoto souboru:
 * Daniel Bubenicek (xbuben05) - bocni menu krome obrazku kachnicky, pojmenovane routy
 * Jan Beran (xberan43) - tabBar a vetsina ostatniho
 */


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/AboutScreen.dart';
import 'package:itu/Asap.dart';
import 'package:itu/DetailTaskScreen.dart';
import 'package:itu/Enums.dart';
import 'package:itu/Maybe.dart';
import 'Controller.dart';
import 'ViewController.dart';
import 'Todo.dart';
import 'Asap.dart';
import 'Maybe.dart';
import 'NewTask.dart';
import 'TasksByStateScreen.dart';


Controller controller = new Controller();
var viewController = new ViewController();

void main() => runApp(
  MaterialApp(
    theme: ThemeData.dark(),
    initialRoute: '/',
    routes:{
      '/': (context) => BigDuckTasks(),
      '/done': (context) => TasksByStateScreen(States.done),
      '/bin': (context) => TasksByStateScreen(States.deleted),
      '/about': (context) => AboutScreen(),
      '/details': (context) => DetailTaskScreen(),
    }
  )
);

class BigDuckTasks extends StatefulWidget {
  @override
  _BigDuckTasksState createState() => _BigDuckTasksState();
}

class _BigDuckTasksState extends State<BigDuckTasks> with WidgetsBindingObserver {
  AppLifecycleState _lastLifecycleState; //to know when app is paused

  Color color = colors[0];
  Text text = texts[0];
  int index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_lastLifecycleState == AppLifecycleState.paused || _lastLifecycleState == AppLifecycleState.inactive || _lastLifecycleState == AppLifecycleState.suspending  )
      {
        controller.saveData();
      }
    return Builder(
          builder: (context) => Center(
            child: DefaultTabController(
              length: 5,
              child: Scaffold(
                drawerEdgeDragWidth: 0.0,
                appBar: AppBar(
                  leading: Container(child: Image.asset('assets/BigDuckSimple.png',),
                    margin: new EdgeInsets.all(10), color: Colors.transparent ) ,
                  bottom: TabBar(
                    onTap: (index){
                      setState(() {
                        this.index = index;
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
                endDrawer: Drawer(
                  child: ListView(
                    children: <Widget>[
                      DrawerHeader(
                        child: Center(child: Column(children: <Widget>[
                          Image.asset('assets/BigDuckSimple.png', height: 100, ), Text("BigDuck To-do",textAlign: TextAlign.right, style: TextStyle(fontSize: 24, color: Colors.black),)],)),
                        decoration: BoxDecoration(
                          color: colors[index],
                        ),
                      ),
                      ListTile(
                        title: Text("Statistics"),
                        leading: Icon(Icons.trending_up),
                        onTap: () async {
                          await Navigator.pushNamed(context, '/details');
                        },
                      ),
                      ListTile(
                        title: Text("Bin"),
                        leading: Icon(Icons.delete),
                        onTap: () async {
                          await Navigator.pushNamed(context, '/bin');
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("Done tasks"),
                        leading: Icon(Icons.done),
                        onTap: () async {
                          await Navigator.pushNamed(context, '/done');
                          Navigator.pop(context);
                        },
                      ),
                      /*
                      ListTile(
                        title: Text("Settings"),
                        onTap: (){
                        },
                      ),*/
                      ListTile(
                        title: Text("About BigDuck Tasks"),
                        leading: Image.asset('assets/BigDuckSimple.png', height: 30, ),
                        onTap: () async {
                          await Navigator.pushNamed(context, '/about');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TodoTab(),
                    AsapTab(),
                    Text("Calendar"),
                    MaybeTab(),
                    Icon(Icons.table_chart),
                  ],
                ),
                floatingActionButton: FloatingActionButton(onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewTask(index: index)),
                  );
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoneTasksScreen(color: this.color)),
                  );*/
                },
                  child: Icon(Icons.add,), backgroundColor: this.color),
              ),
            ),
          ),
        );
  }
}





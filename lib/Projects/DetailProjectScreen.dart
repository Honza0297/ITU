import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:itu/Projects/Project.dart';
import '../Controller.dart';
import '../TaskBox.dart';
import '../ViewController.dart';
import '../Todo.dart';
import '../Task.dart';
import '../main.dart';
import '../Enums.dart';
import 'NewTaskInProject.dart';

Project actualProject;

class DetailProjectScreen extends StatefulWidget {

  DetailProjectScreen({this.project, this.id})
  {actualProject = this.project;}
  Project project;
  int id;
  List<TaskBox> tasks;
  @override
  DetailProjectScreenView createState() => DetailProjectScreenView();

}

class DetailProjectScreenView extends State<DetailProjectScreen> {
  DetailProjectScreenView();

  Project project;
  int id;
  List<TaskBox> tasks = controller.GetTasksInProject(actualProject);
  
  @override
  void initState(){
    viewController.AddProjectScreenView(this);
  }

  void refresh() {
    setState(() {
      tasks = controller.GetTasksInProject(actualProject);
    });
  }

  @override
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text((this.widget.project.title).toString()),
        leading:  IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white, ),
            onPressed: (){
              Navigator.pop(context);
            },

          ),
        ],
      ),
      body: ListView(
        children: tasks,

      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewTaskInProject(project: this.widget.project,)),
        );
      },
          child: Icon(Icons.add,),),
    );
  }
}
class MyToggleButtons extends StatefulWidget{

  MyToggleButtons();


  @override
  MyToggleButtonsState createState() => MyToggleButtonsState();
}

class MyToggleButtonsState extends State<MyToggleButtons>{
  MyToggleButtonsState();
  List<bool> isSelected;
  final EdgeInsets myPadding = EdgeInsets.fromLTRB(1, 5, 1, 10);
  final double height = 60;


  @override
  void initState(){
  }

  void GetType(){
  }

  @override
  Widget build(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(1, 3, 0, 8),
        child: ToggleButtons(
          children: <Widget>[
            MyButton(
              text: "Todo",
              color: colors[0],
              icon: Icons.format_align_left,
            ),
            MyButton(
              text: "Asap",
              color: colors[1],
              icon: Icons.priority_high,
            ),
            MyButton(
              text: "Maybe",
              color: colors[3],
              icon: Icons.not_listed_location,
            ),
            MyButton(
              text: "Project",
              color: colors[4],
              icon: Icons.table_chart,
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
              GetType();
            });
          },
          isSelected: isSelected,
        ),
      ),
    );
  }
}


class MyButton extends StatelessWidget {
  MyButton({Key key, this.text, this.color, this.icon}) :
        super(key: key);


  final String text;
  final EdgeInsets myPadding = EdgeInsets.all(5.0);
  final Color color;
  final IconData icon;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 4),
      child: Column(
          children: <Widget>[
            Icon(icon, color: color, ),
            Text(text, ),//style: TextStyle(color: color)),
          ]),
    );
  }
}

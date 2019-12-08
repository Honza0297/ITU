import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itu/Projects/ProjectBox.dart';
import '../Controller.dart';

import '../main.dart';

class ProjectsTab extends StatefulWidget{
  @override
  ProjectsView createState() => viewController.NewProjectsView();
}

class ProjectsView extends State<ProjectsTab>{
  List<ProjectBox> projects = controller.GetListProjects();
  @override
  Widget build(BuildContext context){
    return ListView(children: projects,);
  }

  void refresh()
  {
    setState(() {
      projects = controller.GetProjects();
    });
  }
}
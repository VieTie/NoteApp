import 'package:flutter/material.dart';
import 'package:noteapp/style/app.dart';

import '../style/home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColor,
        appBar: theAppBar("Reminder"),
        body: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          height: 48.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              label("All"),
              const SizedBox(width: 16.0),
              label("Home"),
              const SizedBox(width: 16.0),
              label("Task"),
              const SizedBox(width: 16.0),
              label("Shopping"),
              const SizedBox(width: 16.0),
              label("➕"),

            ],
          ),
        ),
        drawer: Drawer(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          lightestMainColor,
                          lighterMainColor,
                          mainColor
                        ],
                        tileMode: TileMode.mirror)),
                child: Padding(
                    padding: EdgeInsets.zero,
                    child: ListView(children: [
                      SizedBox(
                          height: 80.0,
                          child: DrawerHeader(
                              child: Center(
                                  child: Text("T-Note",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 32,
                                          color: darkColor))))),
                      ListTile(
                          leading: drawerIcon(Icons.event_note),
                          title: drawerTitle("Notes"),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(height: 8.0),
                      ListTile(
                          leading: drawerIcon(Icons.calendar_month),
                          title: drawerTitle("Calendar"),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(height: 8.0),
                      ListTile(
                          leading: drawerIcon(Icons.view_timeline),
                          title: drawerTitle("Timeline"),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(height: 8.0),
                      ListTile(
                          leading: drawerIcon(Icons.class_rounded),
                          title: drawerTitle("Types"),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(height: 8.0),
                      ListTile(
                          leading:
                              drawerIcon(Icons.domain_verification_rounded),
                          title: drawerTitle("Completed"),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(height: 8.0),
                      ListTile(
                          leading: drawerIcon(Icons.delete_rounded),
                          title: drawerTitle("Trash"),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(height: 8.0),
                      ListTile(
                          leading: drawerIcon(Icons.settings),
                          title: drawerTitle("Setting"),
                          onTap: () {
                            Navigator.pop(context);
                          })
                    ])))));
  }
}

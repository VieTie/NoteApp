import 'package:flutter/material.dart';

import '../style/app.dart';
import '../style/home_style.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: lightColor,
        appBar: theAppBar("Reminder"),
        body: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 292,
                    child: TabBar(
                      isScrollable: true,
                      labelPadding:
                          const EdgeInsets.only(left: 20.0, right: 20.0),
                      indicatorSize: TabBarIndicatorSize.label,
                      //indicatorPadding: EdgeInsets.all(16.0),
                      indicator: BoxDecoration(
                          color: lighterMainColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0))),
                      tabs: [
                        Tab(child: label("All")),
                        Tab(child: label("Home")),
                        Tab(child: label("Task")),
                        Tab(child: label("Shopping"))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 68.0,
                    child: FlatButton(
                        onPressed: () {},
                        child: Icon(Icons.add_circle,
                            color: lighterMainColor, size: 38)),
                  )
                ],
              ),
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
                    ])))),
        floatingActionButton: theFAB(),
      ),
    );
  }
}

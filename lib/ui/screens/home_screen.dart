import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../custom_tab_view.dart';
import '../style/app.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int initPosition = 0;

  @override
  Widget build(BuildContext context) {
    ///TabController
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Reminder"),
      body: Container(
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: types.orderBy('created_time', descending: false).snapshots(),
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 331.428,
                    child: CustomTabView(
                      initPosition: initPosition,
                      itemCount: snapshot.data!.docs.length,
                      tabBuilder: (context, index) => Tab(text: snapshot.data!.docs[index]['type_name']),
                      pageBuilder: (context, index) => Center(child: Text(snapshot.data!.docs[index]['type_color'].toString())),
                      onPositionChange: (index) {
                        if (kDebugMode) {
                          print('current position: $index');
                        }
                        initPosition = index;
                      },
                      onScroll: (position) => print('$position'),
                    ),
                  ),
                    IconButton(
                      padding: const EdgeInsets.all(0.0),
                        onPressed: () {},
                        icon: Icon(Icons.add_circle,
                            color: lighterMainColor, size: 38)),

                ],
              );
            }
          ),
        ),
      ),

      ///Drawer
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

                    /// All notes
                    ListTile(
                        leading: drawerIcon(Icons.event_note),
                        title: drawerTitle("Notes"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(height: 8.0),

                    /// Calendar
                    ListTile(
                        leading: drawerIcon(Icons.calendar_month),
                        title: drawerTitle("Calendar"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(height: 8.0),

                    /// Timeline
                    ListTile(
                        leading: drawerIcon(Icons.view_timeline),
                        title: drawerTitle("Timeline"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(height: 8.0),

                    /// All types of note
                    ListTile(
                        leading: drawerIcon(Icons.class_rounded),
                        title: drawerTitle("Types"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(height: 8.0),

                    /// All notes completed
                    ListTile(
                        leading:
                        drawerIcon(Icons.domain_verification_rounded),
                        title: drawerTitle("Completed"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(height: 8.0),

                    /// All notes deleted
                    ListTile(
                        leading: drawerIcon(Icons.delete_rounded),
                        title: drawerTitle("Trash"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    const SizedBox(height: 8.0),

                    /// Setting
                    ListTile(
                        leading: drawerIcon(Icons.settings),
                        title: drawerTitle("Setting"),
                        onTap: () {
                          Navigator.pop(context);
                        })
                  ])))),
      floatingActionButton: theFAB(),
    );
  }
}

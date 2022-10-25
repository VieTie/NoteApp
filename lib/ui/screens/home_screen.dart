import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/ui/custom_drawer.dart';

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
    return Scaffold(
        backgroundColor: lightColor,
        appBar: theAppBar("Reminder"),
        drawer: const CustomDrawer(),
        floatingActionButton: theFAB(),
        body: Container(
            margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),

            ///TabController
            child: StreamBuilder<QuerySnapshot>(
                stream: types
                    .orderBy('created_time', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomTabView(
                      initPosition: initPosition,
                      itemCount: snapshot.data!.docs.length,
                      tabBuilder: (context, index) =>
                          Tab(text: snapshot.data!.docs[index]['type_name']),

                      ///TabView
                      pageBuilder: (context, index) => Center(
                          child: Text(snapshot.data!.docs[index]['type_color']
                              .toString())),
                      onPositionChange: (index) {
                        initPosition = index;
                      });
                })));
  }
}

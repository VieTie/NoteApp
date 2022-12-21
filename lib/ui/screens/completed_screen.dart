import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../custom_drawer.dart';
import '../custom_tab_view.dart';
import '../style/app.dart';
import '../style/type_style.dart';
import 'note_reader.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  int initPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColor,
        appBar: theAppBar("Completed"),
        drawer: const CustomDrawer(),
        body: Container(
            margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),

            ///TabController
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    types.orderBy('created_time', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return addNewType(context);
                  }
                  return CustomTabView(
                      initPosition: initPosition,
                      itemCount: snapshot.data!.docs.length,
                      tabBuilder: (context, index) =>
                          Tab(text: snapshot.data!.docs[index]['type_name']),

                      ///TabView
                      pageBuilder: (context, index) =>
                          StreamBuilder<QuerySnapshot>(
                              stream: notes
                                  .where("note_type",
                                      isEqualTo: snapshot.data!.docs[index]
                                          ['type_name'])
                                  .where("is_completed", isEqualTo: true)
                                  .orderBy("note_date")
                                  .orderBy("time_start")
                                  .snapshots(),
                              builder: (ctx,
                                  AsyncSnapshot<QuerySnapshot> snapshot2) {
                                if (!snapshot2.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot2.data == null ||
                                    snapshot2.data!.docs.isEmpty) {
                                  return Center(
                                      child: Text(
                                          "No Notes have been Completed",
                                          style: TextStyle(
                                              color: mainColor,
                                              fontSize: 24.0)));
                                }

                                return GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    children: snapshot2.data!.docs
                                        .map((note) => noteCard(
                                                Color(snapshot.data!.docs[index]
                                                    ['type_color']), () {
                                              Navigator.push(
                                                  ctx,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NoteReader(note)));
                                            }, note))
                                        .toList());
                              }),
                      onPositionChange: (index) => initPosition = index);
                })));
  }
}

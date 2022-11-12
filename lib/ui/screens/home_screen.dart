import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/ui/custom_drawer.dart';
import 'package:noteapp/ui/style/type_style.dart';

import '../custom_tab_view.dart';
import '../style/app.dart';
import 'addnote_screen.dart';
import 'note_reader.dart';

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
        floatingActionButton: theFAB(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNote()));
        }),
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
                                      child: Text("There's no Notes",
                                          style: TextStyle(
                                              color: mainColor,
                                              fontSize: 40.0)));
                                }

                                return GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    children: snapshot2.data!.docs
                                        .map((note) => noteCard(
                                                Color(snapshot.data!.docs[index]
                                                        ['type_color'])
                                                    .withOpacity(0.5), () {
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

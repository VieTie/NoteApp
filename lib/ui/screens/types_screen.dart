import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/ui/style/type_style.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Types extends StatefulWidget {
  const Types({Key? key}) : super(key: key);

  @override
  State<Types> createState() => _TypesState();
}

class _TypesState extends State<Types> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColor,
        appBar: theAppBar("Types"),
        drawer: const CustomDrawer(),

        ///The FAB
        floatingActionButton: theFAB(() {
          addType(context);
        }),

        ///List Type
        body: StreamBuilder<QuerySnapshot>(
            stream: types.orderBy('created_time', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return addNewType(context);
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    return typeCard(Color(doc['type_color']), doc['type_name'],
                        doc, context);
                  });
            }));
  }
}

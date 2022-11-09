import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Types extends StatefulWidget {
  const Types({Key? key}) : super(key: key);

  @override
  State<Types> createState() => _TypesState();
}

class _TypesState extends State<Types> {
  String addName = '';
  String editName = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColor,
        appBar: theAppBar("Types"),
        drawer: const CustomDrawer(),

        ///The FAB
        floatingActionButton: theFAB(() {
          Color addColor =
              Colors.primaries[Random().nextInt(Colors.primaries.length)];

          ///Add New Type
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, top: 8.0, right: 8.0),
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8.0, right: 8.0),
                        height: 340.0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.cancel_outlined,
                                            color: Colors.red, size: 32.0)),
                                    Text("Add New Type",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 24.0,
                                            color: mainColor)),
                                    IconButton(
                                        onPressed: () {
                                          if (addName != '' &&
                                              addName.trim() != '') {
                                            types.doc(addName).set({
                                              "type_name": addName,
                                              "type_color": addColor.value,
                                              "created_time": DateTime.now()
                                            });
                                          }
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.done,
                                            color: mainColor, size: 36.0))
                                  ]),
                              TextField(
                                  autofocus: true,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                      hintText: 'Enter Type Name'),
                                  onChanged: (text) {
                                    addName = text;
                                  }),
                              const SizedBox(height: 1.0),
                              SlidePicker(
                                  enableAlpha: false,
                                  pickerColor: addColor,
                                  onColorChanged: (color) {
                                    addColor = color;
                                  })
                            ])));
              });
        }),

        ///List Type
        body: StreamBuilder<QuerySnapshot>(
            stream: types.orderBy('created_time', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Text(
                  "There's no Types",
                  style: TextStyle(color: darkColor, fontSize: 16.0),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    return Container(
                        padding: const EdgeInsets.only(
                            left: 40.0, top: 4.0, right: 20.0, bottom: 4.0),
                        margin: const EdgeInsets.all(appDefaultPadding),
                        decoration: BoxDecoration(
                            color: Color(doc['type_color']).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(45.0)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(doc['type_name'],
                                  style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      color: lightColor,
                                      fontSize: 20.0)),
                              Row(children: [
                                ///Edit Type
                                IconButton(
                                    onPressed: () {
                                      firestore.runTransaction(
                                          (Transaction myTransaction) async {
                                        myTransaction.delete(doc.reference);
                                        _controller.text = doc['type_name'];
                                        Color editColor =
                                            Color(doc['type_color']);
                                        String oldTitle = doc['type_name'];
                                        //noteChange = notes.where('note_type', isEqualTo: oldTitle).get()
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              top: 8.0,
                                                              right: 8.0),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              top: 8.0,
                                                              right: 8.0),
                                                      height: 340.0,
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .cancel_outlined,
                                                                          color: Colors
                                                                              .red,
                                                                          size:
                                                                              32.0)),
                                                                  Text(
                                                                      "Edit Type",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          fontSize:
                                                                              24.0,
                                                                          color:
                                                                              mainColor)),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (editName !=
                                                                                '' &&
                                                                            editName.trim() !=
                                                                                '') {
                                                                          types
                                                                              .doc(editName)
                                                                              .set({
                                                                            "type_name":
                                                                                editName,
                                                                            "type_color":
                                                                                editColor.value,
                                                                            "created_time":
                                                                                DateTime.now()
                                                                          });

                                                                          notes
                                                                              .where('note_type', isEqualTo: oldTitle)
                                                                              .get()
                                                                              .then((querySnapshot) {
                                                                            for (var value
                                                                                in querySnapshot.docs) {
                                                                              value.reference.update({
                                                                                'note_type': editName
                                                                              });
                                                                            }
                                                                          });
                                                                        }
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .done,
                                                                          color:
                                                                              mainColor,
                                                                          size:
                                                                              36.0))
                                                                ]),
                                                            TextField(
                                                                controller:
                                                                    _controller,
                                                                autofocus: true,
                                                                textCapitalization:
                                                                    TextCapitalization
                                                                        .sentences,
                                                                decoration: const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    labelText:
                                                                        'Name',
                                                                    hintText:
                                                                        'Enter Type Name'),
                                                                onChanged:
                                                                    (text) {
                                                                  editName =
                                                                      text;
                                                                }),
                                                            const SizedBox(
                                                                height: 1.0),
                                                            SlidePicker(
                                                                enableAlpha:
                                                                    false,
                                                                pickerColor:
                                                                    editColor,
                                                                onColorChanged:
                                                                    (color) {
                                                                  editColor =
                                                                      color;
                                                                })
                                                          ])));
                                            });
                                      });
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: lightColor)),

                                ///Delete Type
                                IconButton(
                                    onPressed: () {
                                      firestore.runTransaction(
                                          (Transaction myTransaction) async {
                                        myTransaction.delete(doc.reference);
                                        notes
                                            .where('note_type',
                                                isEqualTo: doc['type_name'])
                                            .get()
                                            .then((querySnapshot) {
                                          for (var value
                                              in querySnapshot.docs) {
                                            value.reference.delete();
                                          }
                                        });
                                      });
                                    },
                                    icon: const Icon(Icons.delete_rounded,
                                        color: lightColor))
                              ])
                            ]));
                  });
            }));
  }
}

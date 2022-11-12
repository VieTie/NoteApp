import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'app.dart';

Widget btnCancel(BuildContext context) {
  return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.cancel_outlined, color: Colors.red, size: 32.0));
}

Widget title(String title) {
  return Text(title,
      style: TextStyle(
          fontFamily: "Montserrat", fontSize: 24.0, color: mainColor));
}

Widget iconAddNewType() {
  return Container(
      height: 50.0,
      width: 120.0,
      decoration: BoxDecoration(
          color: mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: const Center(
          child: Text("Add new Types",
              style: TextStyle(fontFamily: "OpenSans", color: lightColor))));
}

void add(String addName, Color addColor) {
  if (addName != '' && addName.trim() != '') {
    types.doc(addName).set({
      "type_name": addName,
      "type_color": addColor.value,
      "created_time": DateTime.now()
    });
  }
}

void edit(String editName, Color editColor, String oldTitle) {
  if (editName != '' && editName.trim() != '') {
    types.doc(editName).set({
      "type_name": editName,
      "type_color": editColor.value,
      "created_time": DateTime.now()
    });
    if (editName != oldTitle) {
      types.doc(oldTitle).delete();
    }
    notes.where('note_type', isEqualTo: oldTitle).get().then((querySnapshot) {
      for (var value in querySnapshot.docs) {
        value.reference.update({'note_type': editName});
      }
    });
  }
}

Future addType(BuildContext context) {
  Color addColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  String addName = '';
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
                margin: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                height: 340.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            btnCancel(context),
                            title("Add New Type"),
                            IconButton(
                                onPressed: () {
                                  add(addName, addColor);
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.done,
                                    color: mainColor, size: 36.0))
                          ]),
                      TextField(
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
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
}

Widget addNewType(BuildContext context) {
  return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Text("There's no Types. Add new type now.",
            style: TextStyle(color: mainColor, fontSize: 16.0)),
        const SizedBox(height: 8.0),
        TextButton(
            onPressed: () {
              addType(context);
            },
            child: iconAddNewType())
      ]));
}

Widget typeCard(
  Color color,
  String name,
  DocumentSnapshot doc,
  BuildContext context,
) {
  String editName = '';
  final TextEditingController controller = TextEditingController();
  return Container(
      padding:
          const EdgeInsets.only(left: 40.0, top: 4.0, right: 20.0, bottom: 4.0),
      margin: const EdgeInsets.all(appDefaultPadding),
      decoration: BoxDecoration(
          color: Color(doc['type_color']),
          borderRadius: BorderRadius.circular(45.0)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              child: Text(doc['type_name'],
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontFamily: "Montserrat",
                      color: lightColor,
                      fontSize: 20.0)),
            ),
            Row(children: [
              ///Edit Type
              IconButton(
                  onPressed: () {
                    controller.text = doc['type_name'];
                    Color editColor = Color(doc['type_color']);
                    String oldTitle = doc['type_name'];
                    editName = oldTitle;

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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              btnCancel(context),
                                              title('Edit Type'),
                                              IconButton(
                                                  onPressed: () {
                                                    edit(editName, editColor,
                                                        oldTitle);
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.done,
                                                      color: mainColor,
                                                      size: 36.0))
                                            ]),
                                        TextField(
                                            controller: controller,
                                            autofocus: true,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Name',
                                                hintText: 'Enter Type Name'),
                                            onChanged: (text) {
                                              editName = text;
                                            }),
                                        const SizedBox(height: 1.0),
                                        SlidePicker(
                                            enableAlpha: false,
                                            pickerColor: editColor,
                                            onColorChanged: (color) {
                                              editColor = color;
                                            })
                                      ])));
                        });
                  },
                  icon: const Icon(Icons.edit, color: lightColor)),

              ///Delete Type
              IconButton(
                  onPressed: () {
                    firestore.runTransaction((Transaction myTransaction) async {
                      myTransaction.delete(doc.reference);
                      notes
                          .where('note_type', isEqualTo: doc['type_name'])
                          .get()
                          .then((querySnapshot) {
                        for (var value in querySnapshot.docs) {
                          value.reference.delete();
                        }
                      });
                    });
                  },
                  icon: const Icon(Icons.delete_rounded, color: lightColor))
            ])
          ]));
}

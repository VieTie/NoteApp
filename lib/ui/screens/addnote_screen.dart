import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:noteapp/ui/style/addNote_style.dart';
import 'package:noteapp/ui/style/app.dart';


class AddNote extends StatefulWidget {
  const AddNote({super.key, this.restorationId});
  final String? restorationId;
  @override
  State<StatefulWidget> createState() => _addNoteState();
}

class _addNoteState extends State<AddNote> {
  //Color colorChange = btnColor;
  Color buttonColor = btnColor;
  Color textChange = Colors.white;
  //Color textColor = darkColor;
  DateTime _selectedDate = DateTime.now();
  // void _changeColor() {
  //   setState(() {
  //     buttonColor = colorChange;
  //     textColor = textChange;
  //   });
  // }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print("Show Date Picker");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
      child: Scaffold(
        backgroundColor: lightColor,
        appBar: noteAppBar(),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 8),
            child: Column(
              children: [
                const TextField(
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Montserrat',
                    color: btnColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.blue,
                    hintText: "Event Title",
                    hintStyle: TextStyle(
                        color: btnColor,
                        fontSize: 30,
                        fontFamily: 'Montserrat'),
                    //enabled: false,
                  ),
                ),
                Container(
                  height: 45,
                  child: Row(
                      // scrollDirection: Axis.horizontal,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                NoteButton(
                                  text: "Home",
                                  press: () {
                                    // _changeColor;
                                  },
                                  textcolor: btnColor,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                NoteButton(
                                  text: "Shopping",
                                  press: () {
                                    // _changeColor;
                                  },
                                  textcolor: btnColor,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                NoteButton(
                                  text: "Work",
                                  press: () {},
                                  textcolor: btnColor,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                NoteButton(
                                  text: "Sport",
                                  press: () {},
                                  textcolor: btnColor,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                NoteButton(
                                  text: "Jobs",
                                  press: () {},
                                  textcolor: btnColor,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: FlatButton(
                              onPressed: () {},
                              padding: EdgeInsets.only(left: 0),
                              child: Icon(Icons.add_circle,
                                  color: btnColor, size: 40)),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  //color: Colors.white,
                  width: double.maxFinite,
                  height: 45,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(246, 255, 255, 255)),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(344.6, 45),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24)))),
                        ),
                        onPressed: () {
                          _presentDatePicker();
                        },
                        icon: Icon(
                          Icons.edit_calendar,
                          size: 35,
                          color: btnColor,
                        ),
                        label: Text(
                          _selectedDate == null
                              ? 'No Date Chosen!'
                              : DateFormat.yMd().format(_selectedDate),
                          style: TextStyle(
                              color: btnColor,
                              fontSize: 25,
                              fontFamily: "Montserrat"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NoteTimePicker("Start"),
                        NoteTimePicker("End"),
                      ]),
                ),
                SizedBox(
                  height: 25,
                ),
                NoteInputText("Decription", listnote),
                SizedBox(
                  height: 20,
                ),
                NoteInputText("Repeat", looptime),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

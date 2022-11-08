//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/ui/style/addNote_style.dart';
import 'package:noteapp/ui/style/app.dart';
// import 'package:noteapp/ui/style/home_style.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _addNoteState();
}

class _addNoteState extends State<AddNote> {
  Color colorChange = btnColor;
  Color buttonColor = Colors.white;
  Color textChange = Colors.white;
  Color textColor = darkColor;
  void _changeColor() {
    setState(() {
      buttonColor = colorChange;
      textColor = textChange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: lightColor,
        appBar: noteAppBar(),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0),
            child: Column(
              children: [
                TextField(
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
                                    _changeColor;
                                  },
                                  textcolor: Colors.white,
                                  color: buttonColor,
                                ),
                                NoteButton(
                                  text: "Shopping",
                                  press: () {
                                    _changeColor;
                                  },
                                  textcolor: textColor,
                                  color: buttonColor,
                                ),
                                NoteButton(
                                  text: "Work",
                                  press: () {},
                                  textcolor: btnColor,
                                  color: Colors.white,
                                ),
                                NoteButton(
                                  text: "Sport",
                                  press: () {},
                                  textcolor: btnColor,
                                  color: Colors.white,
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
                          width: 50,
                          child: FlatButton(
                              onPressed: () {},
                              padding: EdgeInsets.only(left: 0),
                              child: Icon(Icons.add_circle,
                                  color: lighterMainColor, size: 38)),
                        ),
                      ]),
                ),
                // /Spacer(),
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
                        //padding: EdgeInsets.only(left: 0),
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit_calendar,
                          size: 35,
                          color: btnColor,
                        ),
                        label: Text(
                          "17 Monday 2022",
                          style: TextStyle(
                              color: btnColor,
                              fontSize: 27,
                              fontFamily: "Montserrat"),
                        ),
                      )
                    ],
                  ),
                ),
                //Spacer(),
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
                //Spacer(),
                NoteInputText("Decription", listnote),
                NoteInputText("Repeat", looptime),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

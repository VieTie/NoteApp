// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/ui/style/app.dart';

class NoteButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  // ignore: prefer_typing_uninitialized_variables
  final color;
  final textcolor;
  //final EdgeInsets padding;

  const NoteButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = lightColor,
    this.textcolor = lightColor,
    //this.padding = const EdgeInsets.only(left: 8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      onPressed: press,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      //padding: padding,
      color: color,
      textColor: textcolor,
      //minWidth: double.infinity,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
      ),
    );
  }
}

Icon listnote = Icon(
  Icons.format_list_bulleted,
  color: btnColor,
);
Icon looptime = Icon(
  Icons.loop,
  color: btnColor,
);

AppBar noteAppBar() {
  return AppBar(
    toolbarHeight: 40,
    elevation: 0.0,
    // leadingWidth: double.maxFinite,
    backgroundColor: lightColor,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
          color: btnColor,
          iconSize: 25,
        );
      },
    ),
    actions: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 16.0),
        child: ButtonTheme(
          height: 20,
          minWidth: 20,
          child: NoteButton(
            text: "Save",
            press: () {},
            textcolor: btnColor,
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}

// ignore: deprecated_member_use
// RaisedButton pressNoteButton(String name, VoidCallback press) {
//   return RaisedButton(
//     onPressed: () => press,
//     child: Text(
//       name,
//       style: TextStyle(color: btnColor, fontSize: 20),
//     ),
//     textColor: btnColor,
//     shape: new RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(24))),
//     color: Colors.white,
//     highlightColor: pressAttention ? Colors.white : btnColor,
//     //onHighlightChanged: ,
//   );
// }

bool pressAttention = false;

Column NoteTimePicker(String name) {
  return Column(children: [
    Container(
      //alignment: AlignmentGeometry.lerp(a, b, t),
      width: 100,
      height: 200,
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
                color: btnColor, fontSize: 25, fontFamily: 'Montserrat'),
          ),
          // SizedBox(
          //     width: 100,
          //     height: 180,
          Expanded(
            child: CupertinoTheme(
              data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                          color: btnColor, fontFamily: 'Montserrat'))),
              child: CupertinoDatePicker(
                use24hFormat: true,
                //backgroundColor: btnColor,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {},
                initialDateTime: DateTime.now(),
              ),
            ),
          )
        ],
      ),
    ),
  ]);
}

Container NoteInputText(String name, Icon a) {
  return Container(
    height: 45,
    child: TextField(
      style: TextStyle(
        fontSize: 24,
        fontFamily: 'Montserrat',
        color: btnColor,
      ),
      decoration: InputDecoration(
        // border: InputBorder.none,
        fillColor: Colors.blue,
        prefixIcon: a,
        hintText: name,
        hintStyle:
            TextStyle(color: btnColor, fontSize: 20, fontFamily: 'Montserrat'),
        //enabled: false,
      ),
    ),
  );
}

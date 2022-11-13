import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/ui/style/app.dart';

Widget noteButton(String text, VoidCallback press) {
  Color color = Colors.white;
  Color textColor = btnColor;
  return MaterialButton(
      elevation: 0.0,
      height: 40,
      onPressed: press,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      color: color,
      textColor: textColor,
      child: Text(text,
          style: const TextStyle(fontSize: 20, fontFamily: 'Montserrat')));
}

Column noteTimePicker(String name, DateTime pickedTime) {
  return Column(children: [
    SizedBox(
        width: 100,
        height: 200,
        child: Column(children: [
          Text(name,
              style: const TextStyle(
                  color: btnColor, fontSize: 24, fontFamily: 'Montserrat')),
          Expanded(
              child: CupertinoTheme(
                  data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                              color: btnColor, fontFamily: 'Montserrat'))),
                  child: CupertinoDatePicker(
                      use24hFormat: true,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (value) {
                        pickedTime = DateFormat.Hm().format(value) as DateTime;
                      },
                      initialDateTime: pickedTime)))
        ]))
  ]);
}

TextField noteInputText(String name, Icon a, String txt) {
  return TextField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: const TextStyle(
          fontSize: 24, fontFamily: 'Montserrat', color: btnColor),
      decoration: InputDecoration(
          fillColor: Colors.blue,
          prefixIcon: a,
          hintText: name,
          hintStyle: const TextStyle(
              color: btnColor, fontSize: 20, fontFamily: 'Montserrat')),
      onChanged: (text) {
        txt = text;
      });
}

Widget customButton(String type, String label) {
  return FocusableControlBuilder(onPressed: () {
    type = label;
  }, builder: (_, FocusableControlState control) {
    double size = control.isFocused ? 22 : 20;
    Color textColor = control.isFocused ? Colors.white : darkColor;
    Color bgColor = control.isFocused ? mainColor : Colors.white;
    Color borderColor = control.isHovered ? mainColor : Colors.white;
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(16.0))),
        child: Text(label,
            style: TextStyle(
                fontSize: size, fontFamily: 'Montserrat', color: textColor)));
  });
}

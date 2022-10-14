import 'package:flutter/material.dart';
import 'package:noteapp/style/app.dart';

InkWell label(String title) {
  Color bgColor = lessDarkColor;
  Color txtColor = lightTextColor;

  return InkWell(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: bgColor,
            borderRadius: BorderRadius.all(const Radius.circular(16.0))),
        // focus
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: "OpenSans",
              color: txtColor,
              fontSize: 16
            ),
          ),
        ),
      ),
      onTap: () {
        bgColor = btnColor;
        txtColor = lightColor;
      }
  );
}

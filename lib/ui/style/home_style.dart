import 'package:flutter/material.dart';

import 'app.dart';

Container label(String title) {
  return Container(
      margin: const EdgeInsets.all(8.0),
      // height: 48.0,
      // padding: const EdgeInsets.all(8.0),
      // decoration: BoxDecoration(
      //     color: bgColor,
      //     borderRadius: const BorderRadius.all(Radius.circular(16.0))),
      child: Center(
          child: Text(title,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: darkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800))));
}

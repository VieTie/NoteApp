import 'package:flutter/material.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Timeline"),
      drawer: const CustomDrawer(),
    );
  }
}

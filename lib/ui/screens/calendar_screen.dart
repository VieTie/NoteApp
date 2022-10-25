import 'package:flutter/material.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Calendar"),
      drawer: const CustomDrawer(),
    );
  }
}

import 'package:flutter/material.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Completed"),
      drawer: const CustomDrawer(),
    );
  }
}

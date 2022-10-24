import 'package:flutter/material.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Trash extends StatefulWidget {
  const Trash({Key? key}) : super(key: key);

  @override
  State<Trash> createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Trash"),
      drawer: const CustomDrawer(),
    );
  }
}

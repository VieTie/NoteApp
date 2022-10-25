import 'package:flutter/material.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Types extends StatefulWidget {
  const Types({Key? key}) : super(key: key);

  @override
  State<Types> createState() => _TypesState();
}

class _TypesState extends State<Types> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Types"),
      drawer: const CustomDrawer(),
    );
  }
}

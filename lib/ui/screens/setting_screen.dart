import 'package:flutter/material.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Setting"),
      drawer: const CustomDrawer(),
    );
  }
}

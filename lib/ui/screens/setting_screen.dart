import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_drawer.dart';
import '../style/add_style.dart';
import '../style/app.dart';
import 'login_screen.dart';

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
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 16.0,
                  child: ButtonTheme(
                      height: 20,
                      minWidth: 20,
                      child: noteButton("Sign Out", () async {
                        final pref = await SharedPreferences.getInstance();
                        pref.setBool('isLoggedIn', false);
                        auth.signOut();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const Login()));
                      })))
            ])));
  }
}

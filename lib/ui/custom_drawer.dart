import 'package:flutter/material.dart';
import 'package:noteapp/ui/screens/calendar_screen.dart';
import 'package:noteapp/ui/screens/completed_screen.dart';
import 'package:noteapp/ui/screens/home_screen.dart';
import 'package:noteapp/ui/screens/setting_screen.dart';
import 'package:noteapp/ui/screens/trash_screen.dart';
import 'package:noteapp/ui/screens/types_screen.dart';
import 'package:noteapp/ui/style/app.dart';
import 'package:noteapp/ui/screens/timeline_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      lightestMainColor,
                      lighterMainColor,
                      mainColor
                    ],
                    tileMode: TileMode.mirror)),
            child: ListView(children: [
              SizedBox(
                  height: 80.0,
                  child: DrawerHeader(
                      child: Center(
                          child: Text("T-Note",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 32,
                                  color: darkColor))))),

              /// All notes
              ListTile(
                  leading: drawerIcon(Icons.event_note),
                  title: drawerTitle("Notes"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  }),
              const SizedBox(height: 8.0),

              /// Calendar
              ListTile(
                  leading: drawerIcon(Icons.calendar_month),
                  title: drawerTitle("Calendar"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Calendar()));
                  }),
              const SizedBox(height: 8.0),

              /// Timeline
              ListTile(
                  leading: drawerIcon(Icons.view_timeline),
                  title: drawerTitle("Timeline"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Timeline()));
                  }),
              const SizedBox(height: 8.0),

              /// All types of note
              ListTile(
                  leading: drawerIcon(Icons.class_rounded),
                  title: drawerTitle("Types"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Types()));
                  }),
              const SizedBox(height: 8.0),

              /// All notes completed
              ListTile(
                  leading: drawerIcon(Icons.domain_verification_rounded),
                  title: drawerTitle("Completed"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Completed()));
                  }),
              const SizedBox(height: 8.0),

              /// All notes deleted
              ListTile(
                  leading: drawerIcon(Icons.delete_rounded),
                  title: drawerTitle("Trash"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Trash()));
                  }),
              const SizedBox(height: 8.0),

              /// Setting
              ListTile(
                  leading: drawerIcon(Icons.settings),
                  title: drawerTitle("Setting"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Setting()));
                  })
            ])));
  }
}

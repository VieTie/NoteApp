import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteapp/ui/screens/login_screen.dart';

const Color lightColor = Color(0xFFEDF4F6);
Color darkColor = const Color(0xFF1C1F20);
Color lessDarkColor = const Color(0xFFD9D9D9);
const Color btnColor = Color.fromARGB(255, 7, 164, 216);
Color mainColor = const Color(0xFF0798C9);
Color lighterMainColor = const Color(0xBF0798C9);
Color lightestMainColor = const Color(0x4D0798C9);
Color lightTextColor = const Color(0xBF1C1F20);
const appDefaultPadding = 8.0;

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference users = FirebaseFirestore.instance.collection('Users');
CollectionReference notes =
    users.doc(User1.static_uid).collection('Notes');
CollectionReference types =
    users.doc(User1.static_uid).collection('Types');

FirebaseAuth auth = FirebaseAuth.instance;

// CollectionReference notes = FirebaseFirestore.instance.collection('Notes').doc(uid) as CollectionReference<Object?>;
// CollectionReference types = FirebaseFirestore.instance.collection('Types').doc(uid) as CollectionReference<Object?>;

// The main AppBar
AppBar theAppBar(String title) {
  return AppBar(
      leading: Builder(
          builder: (context) => IconButton(
              icon:
                  const Icon(Icons.menu_rounded, color: Colors.black, size: 32),
              onPressed: () => Scaffold.of(context).openDrawer())),
      title: Text(title,
          style: const TextStyle(
              fontFamily: "Montserrat", fontSize: 28, color: Colors.black)),
      elevation: 0.0,
      backgroundColor: lightColor);
}

// The FloatingActionButton to add new note
FloatingActionButton theFAB(Function()? onPress) {
  return FloatingActionButton(
      onPressed: onPress,
      child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    lightestMainColor,
                    lighterMainColor,
                    mainColor
                  ],
                  tileMode: TileMode.mirror)),
          child: const Icon(Icons.add, size: 40, color: lightColor)));
}

// Icon used in drawer
Icon drawerIcon(IconData icon) {
  return Icon(icon, size: 40, color: darkColor);
}

// Title used in drawer
Text drawerTitle(String title) {
  return Text(title,
      style: TextStyle(fontFamily: "Poppins", fontSize: 20, color: darkColor));
}

TextStyle titleStyle() {
  return const TextStyle(
      color: lightColor, fontSize: 16.0, fontFamily: "Montserrat");
}

TextStyle contentStyle() {
  return const TextStyle(
      color: lightColor,
      fontSize: 16.0,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.w200);
}

TextStyle timeStyle() {
  return const TextStyle(
      color: lightColor,
      fontSize: 16.0,
      fontFamily: "OpenSans",
      fontWeight: FontWeight.w200);
}

TextStyle repeatStyle() {
  return const TextStyle(
      color: lightColor, fontSize: 14.0, fontFamily: "Montserrat");
}

Widget noteCard(Color color, Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8.0)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(doc["note_title"],
                  style: titleStyle(), overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2.0),
              RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(style: contentStyle(), children: <TextSpan>[
                    const TextSpan(
                        text: "Description: ",
                        style: TextStyle(fontFamily: "Montserrat")),
                    TextSpan(text: doc["note_description"])
                  ])),
              const SizedBox(height: 1.0),
              RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(style: contentStyle(), children: <TextSpan>[
                    const TextSpan(
                        text: "Location: ",
                        style: TextStyle(fontFamily: "Montserrat")),
                    TextSpan(text: doc["note_location"])
                  ])),
              const SizedBox(height: 1.0),
              // Text(doc["note_repeat"],
              //     style: repeatStyle(), overflow: TextOverflow.ellipsis),
              // const SizedBox(height: 2.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                    '${DateFormat.Hm().format(doc['time_start'].toDate())} - ${DateFormat.Hm().format(doc['time_end'].toDate())}  ${DateFormat.yMd().format(doc['note_date'].toDate())}',
                    style: timeStyle()),
              )
            ])),
      ));
}

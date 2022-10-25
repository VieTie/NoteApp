import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const Color lightColor = const Color(0xFFEDF4F6);
Color darkColor = const Color(0xFF1C1F20);
Color lessDarkColor = const Color(0xFFD9D9D9);
Color btnColor = const Color(0xFF0798C9);
Color mainColor = const Color(0xFF0798C9);
Color lighterMainColor = const Color(0xBF0798C9);
Color lightestMainColor = const Color(0x4D0798C9);
Color lightTextColor = const Color(0xBF1C1F20);
const appDefaultPadding = 8.0;

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference notes = FirebaseFirestore.instance.collection('Notes');
CollectionReference types = FirebaseFirestore.instance.collection('Types');

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
FloatingActionButton theFAB() {
  return FloatingActionButton(
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
          child: Icon(Icons.add, size: 40, color: lightColor)),
      onPressed: () {});
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

// Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
//   return InkWell(
//     onTap: onTap,
//     child: Container(
//       padding: const EdgeInsets.all(8.0),
//       margin: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Color(int.parse("0x$doc['type_color']")),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             doc["note_title"],
//             style: AppStyle.mainTitle,
//           ),
//           const SizedBox(
//             height: 4.0,
//           ),
//           Text(
//             doc["creation_date"],
//             style: AppStyle.dateTitle,
//           ),
//           const SizedBox(
//             height: 8.0,
//           ),
//           Text(
//             doc["note_content"],
//             style: AppStyle.mainContent,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';

Color lightColor = const Color(0xFFEDF4F6);
Color darkColor = const Color(0xFF1C1F20);
Color lessDarkColor = const Color(0xFFD9D9D9);
Color btnColor = const Color(0xFF0798C9);
Color mainColor = const Color(0xFF0798C9);
Color lighterMainColor = const Color(0xBF0798C9);
Color lightestMainColor = const Color(0x4D0798C9);
Color lightTextColor = const Color(0xBF1C1F20);

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
                colors: <Color>[lightestMainColor, lighterMainColor, mainColor],
                tileMode: TileMode.mirror)),
        child: Icon(Icons.add, size: 40, color: lightColor)),
    onPressed: () {},
  );
}

Icon drawerIcon(IconData icon) {
  return Icon(icon, size: 40, color: darkColor);
}

Text drawerTitle(String title) {
  return Text(title,
      style:
          TextStyle(fontFamily: "Montserrat", fontSize: 20, color: darkColor));
}

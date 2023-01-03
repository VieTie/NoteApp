import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/ui/screens/home_screen.dart';
import 'package:noteapp/ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var phone = pref.getString('phone');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: phone == null ? const Login() : const Home()));
      // home: Home()) );
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const
//   }
// }

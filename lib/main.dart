import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/ui/screens/home_screen.dart';
import 'package:noteapp/ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final pref = await SharedPreferences.getInstance();
  final isLoggedIn = pref.getBool('isLoggedIn') ?? false;
  var phone = pref.getString('phone');
  runApp(MyApp(isLoggedIn: isLoggedIn));
  // home: Home()) );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoggedIn ? const Home() : const Login(),
    );
  }
}

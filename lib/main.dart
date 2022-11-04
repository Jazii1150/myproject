import 'package:flutter/material.dart';
import 'package:mobie1/aboutus.dart';
import 'package:mobie1/drink_add.dart';
import 'package:mobie1/drink.dart';
import 'package:mobie1/feedback.dart';
import 'package:mobie1/feedback_add.dart';
import 'package:mobie1/icecream_add.dart';
import 'package:mobie1/icecream.dart';
import 'package:mobie1/mainfirst.dart';
import 'package:mobie1/login.dart';
import 'package:mobie1/premain.dart';
import 'package:mobie1/register.dart';
import 'package:mobie1/mainsecond.dart';
import 'package:mobie1/profileinfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobie1/sidedish_add.dart';
import 'package:mobie1/sidedish.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
      primarySwatch: Colors.red,
      ),
      initialRoute: '/premain',
      routes: {
        
        '/premain':(context) => const PreMainPage(),
        '/': (context) => const MainFirst(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/mainsecond': (context) => const MainSecond(),
        '/ice':(context) => IceCreaPage(),
        '/addice':(context) => const AddIceCreaPage(),
        '/side':(context) => SideDPage(),
        '/addside':(context) => const AddSideDPage(),
        '/drin':(context) => DrinPage(),
        '/adddrin':(context) => const AddDrinPage(),
        '/profile': (context) => const ProfilePage(),
        '/aboutus': (context) => const AboutUs(),
        '/feedback': (context) => FeedBackPage(),
        '/addfeed':(context) => const AddFeedBackPage()
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:mobie1/mainfirst.dart';
import 'dart:convert';
import 'package:mobie1/mainsecond.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formstate = GlobalKey<FormState>();
  String? email;
  String? password;
  final auth = FirebaseAuth.instance;

  int _counter = 0;
  String? message;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";

  initState() {
    message = "No message.";

    var initializationSettingsAndroid =
        AndroidInitializationSettings('notiicon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {
      print("onDidReceiveLocalNotification called.");
    });

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      // when user tap on notification.
      print("onSelectNotification called.");
      setState(() {
        message = payload.payload;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: buidReturn(context),
        title: Text('Login Page',
          style: GoogleFonts.shrikhand(
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(255, 255, 255, 1.0),
          )),
        backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
      ),
      body: Material(
        color: const Color.fromRGBO(252, 243, 233, 1.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formstate,
          child: ListView(
            children: <Widget>[
              const Spacer(),
              Image.asset('assets/login.png', //รูปไอคอนเค้ก
                  height: 220,
                  width: 220,
              ),
              emailTextFormField(),
              const SizedBox(height: 15,),
              passwordTextFormField(),
              const SizedBox(height: 15,),
              SizedBox(
              width: 300,
              height: 50,
              child: loginButton()
            ),
            const Spacer(),
        ],
      ),
    ),)
    )
      );
  }

  IconButton buidReturn(BuildContext context) {
    return IconButton(
icon: const Icon(Icons.keyboard_return_outlined,
color: Color.fromRGBO(255, 77, 77, 1.0),
),
onPressed: () {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const MainFirst()), 
  ModalRoute.withName('/mainfirst')
  );
},

);
  }

  sendNotification() async {
  const BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('drink'),
      largeIcon: DrawableResourceAndroidBitmap('drink'),
      contentTitle: 'Welcome <b> Sweetener </b> ',
      htmlFormatContentTitle: true,
      summaryText: 'Sweetday App',
      htmlFormatSummaryText: true,
    );

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '10000',
      'FLUTTER_NOTIFICATION_CHANNEL',
      channelDescription: 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation ,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
       111, 'Hi dear Sweetener', 'Welcome to Sweetday App', platformChannelSpecifics,
        payload: 'I just haven\'t Met You Yet');
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30)
                      )
                    ),
                    backgroundColor: const Color.fromRGBO(255, 77, 77, 1.0),
                  ),
      child: Text('Login',
                    style: GoogleFonts.shrikhand(
                      fontSize: 25.0,
                      color: const Color.fromRGBO(252, 243, 233, 1.0),
                    )
                  ),
      onPressed: () async {
        if(_formstate.currentState!.validate()) {
          print('Valid Form');
          _formstate.currentState!.save();
          try {
            await auth
            .signInWithEmailAndPassword(
              email: email!,
              password: password!
            )
            .then((value) async {
              if (value.user!.emailVerified) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login Pass",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1.0),
                      decorationColor: Color.fromRGBO(228, 76, 16, 1.0)
                    ),)
                  )
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainSecond()),
                  ModalRoute.withName('/mainsecond')
                );
                sendNotification();
              } 
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please verify email")
                  )
                );
              }
            })
            .catchError((reason) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Login or Password Invalid")
                )
              );
            });
          }
          on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
            }
            else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
            }
          }
        }
        else
          print('Invalid Form');
      }
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      onSaved: (value) {
        password = value!.trim();
      },
      validator: (value) {
        if (value!.length < 8)
          return 'Please Enter more than 8 Character';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(255, 77, 77, 1.0),
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(255, 77, 77, 1.0),
          )
        ),
        border: OutlineInputBorder(),
        labelText: 'Password',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      onSaved: (value) {
        email = value!.trim();
      },
      validator: (value) {
        if (!validateEmail(value!))
          return 'Please fill in E-mail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(255, 77, 77, 1.0),
          )
        ),
        enabledBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.all(
          //   Radius.circular(30)
          // ),
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(255, 77, 77, 1.0),
          )
        ),
        border: OutlineInputBorder(),
        labelText: 'E-mail',
        icon: Icon(Icons.email),
        hintText: 'x@x.com',
      ),
    );
  }

  bool validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return (!regex.hasMatch(value)) ? false : true;
  }
}
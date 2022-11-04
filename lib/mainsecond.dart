import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart'; //
import 'package:firebase_auth/firebase_auth.dart'; //
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart'; //
import 'package:image_picker/image_picker.dart';
import 'package:mobie1/mainfirst.dart';
import 'package:mobie1/promotion.dart'; //

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MainSecond());
}

class MainSecond extends StatefulWidget {
  const MainSecond({Key? key}) : super(key: key);

  @override
  State<MainSecond> createState() => _MainSecondState();
}

class _MainSecondState extends State<MainSecond> {
  final auth = FirebaseAuth.instance;

  int _counter = 0;
  String? message;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    File? _avatar;

  @override
  initState() {
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

    initFirebaseMessaging();

    super.initState();
  }

  void initFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (android != null) {
        var a = notification.title.toString();
        var b = notification.body.toString();
        sendNotification(a, b);
      }
    });

    firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("Token : $token");
    });
  }

  sendNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '10000',
      'FLUTTER_NOTIFICATION_CHANNEL',
      channelDescription: 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        111, title, body, platformChannelSpecifics,
        payload: 'I just haven\'t Met You Yet');
  }

  Future<void> sendPushMessage() async {
    firebaseMessaging.getToken().then((String? _token) async {
      assert(_token != null);
      if (_token == null) {
        print('Unable to send FCM message, no token exists.');
        return;
      }

      var st = constructFCMPayload(_token);
      try {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAAF4meEBE:APA91bG6blYXriOJiE-VERWkjkVAqz286c63QJQOg_a0XDsWk7vt9czLNQo80jTHzcp2oAxbRXq3-IUp-GSAj3sSk1n91zkU1etiuUHDoOSdz_rvgQqiYLpr5aheMKV6pCypieWiIrD0',
          },
          body: st,
        );
        print('FCM request for device sent!');
      } catch (e) {
        print(e);
      }
      print("Token : $_token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 243, 233, 1.0),
        //leading: buildReturn(context),
        title: Text('Sweetday',
            style: GoogleFonts.shrikhand(
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(255, 77, 77, 1.0),
            )),
        actions: [buttonLogout(context)],
      ),
      body: Promotion(),
      //bottomNavigationBar: BottomBar(),
      //buildBody(context),
      drawer: buildDrawer(context),
    );
  }

  IconButton buildReturn(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.keyboard_return_outlined,
        color: Color.fromRGBO(255, 77, 77, 1.0),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainFirst()),
            ModalRoute.withName('/mainfirst'));
      },
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(247, 226, 216, 1.0),
      child: Drawer(
        backgroundColor: const Color.fromRGBO(247, 226, 216, 1.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: null,
              accountEmail: null,
              currentAccountPicture: _avatar == null
                  ? GestureDetector(
                      onTap: () {
                        onChooseImage();
                      },
                      child: CircleAvatar(),
                    )
                  : GestureDetector(
                      onTap: () {
                        onChooseImage();
                      },
                      child: Image.file(
                        _avatar!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded,
                  color: Color.fromRGBO(255, 77, 77, 1.0),),
              title: Text(
                'Edit Bio',
                style: GoogleFonts.syne(
                    ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.message_rounded,
                  color: Color.fromRGBO(255, 77, 77, 1.0),
              ),
              title: Text(
                'Feedback',
                style: GoogleFonts.syne(
                    ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle_rounded,
                color: Color.fromRGBO(255, 77, 77, 1.0),
              ),
              title: Text('About Us',
                style: GoogleFonts.syne(),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/aboutus');
              },
            ),
          ],
        ),
      ),
    );
  }

  onChooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _avatar = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    // _avatar == null
    //     ? ElevatedButton(
    //         onPressed: () {
    //           onChooseImage();
    //         },
    //         child: const Text('Choose Avatar'),
    //       )
    //     : Column(
    //         children: [
    //           Image.file(_avatar!),
    //           ElevatedButton(
    //             onPressed: () {
    //               onChooseImage();
    //             },
    //             child: const Text('Change Avatar'),
    //           )
    //         ],
    //       );
  }

  IconButton buttonLogout(context) {
    return IconButton(
      icon: const Icon(
        Icons.exit_to_app_rounded,
        color: Color.fromRGBO(255, 77, 77, 1.0),
      ),
      onPressed: () {
        auth.signOut();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainFirst()),
            ModalRoute.withName('/'));
      },
    );
  }

  ElevatedButton buttonIceCream(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
          Color.fromRGBO(228, 76, 16, 1.0),
        )),
        onPressed: () {
          Navigator.pushNamed(context, '/icecream');
        },
        child: Container(
            decoration: const BoxDecoration(
                //color: Color.fromRGBO(249, 98, 62, 1.0),
                ),
            //padding: const EdgeInsets.all(10.0),
            child: const Icon(
              Icons.icecream_rounded,
              color: Color.fromRGBO(255, 255, 255, 1.0),
              size: 50,
            )));
  }

  ElevatedButton buttonSideDish(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
          Color.fromRGBO(228, 76, 16, 1.0),
        )),
        onPressed: () {
          Navigator.pushNamed(context, '/sidedish');
        },
        child: Container(
            decoration: const BoxDecoration(
                //color: Color.fromRGBO(249, 98, 62, 1.0),
                ),
            //padding: const EdgeInsets.all(10.0),
            child: const Icon(
              Icons.food_bank_rounded,
              color: Color.fromRGBO(255, 255, 255, 1.0),
              size: 50,
            )));
  }

  ElevatedButton buttonDrinks(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
          Color.fromRGBO(228, 76, 16, 1.0),
        )),
        onPressed: () {
          Navigator.pushNamed(context, '/drink');
        },
        child: Container(
            decoration: const BoxDecoration(
                //color: Color.fromRGBO(249, 98, 62, 1.0),
                ),
            //padding: const EdgeInsets.all(10.0),
            child: const Icon(
              Icons.local_drink_rounded,
              color: Color.fromRGBO(255, 255, 255, 1.0),
              size: 50,
            )));
  }

  int _messageCount = 0;
  String constructFCMPayload(String token) {
    _messageCount++;
    return jsonEncode({
      'to': token,
      'data': {
        'via': 'Firebase Cloud Messaging!!! ',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'Hello Firebase Cloud Messaging!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
  }
}

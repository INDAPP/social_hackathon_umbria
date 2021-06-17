import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/home.dart';
import 'package:social_hackathon_umbria/login.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  StreamSubscription<User?>? _userSubscription;

  @override
  void initState() {
    super.initState();
    final userStream = FirebaseAuth.instance.authStateChanges();
    _userSubscription = userStream.listen(_onUserChanged);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Social Hackathon",
      home: FirebaseAuth.instance.currentUser != null ? Home() : Login(),
      theme: _createTheme(),
      );

  void _onUserChanged(User? user) {
    final usr = user;
    print("User: $user");
    if (usr != null) {
      /// utente loggato
      _setupPushNotification();
    } else {
      /// utente sloggato
      _disablePushNotification();
    }
  }

  void _setupPushNotification() async {
    /// richiesta permessi per iOS
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print(settings);

    /// recupero token fcm
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");

    /// mi iscrivo al topic dei post in bacheca
    await FirebaseMessaging.instance.subscribeToTopic("posts");
  }

  void _disablePushNotification() async {
    /// cancella l'fcm token precedentemente creato
    await FirebaseMessaging.instance.deleteToken();

    /// mi cancello dal topic dei post
    await FirebaseMessaging.instance.unsubscribeFromTopic("posts");
  }

  ThemeData _createTheme() => ThemeData(
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    accentColorBrightness: Brightness.light,
    primarySwatch: Colors.grey,
    primaryColor: Colors.blue,
    accentColor: Colors.amber,
    scaffoldBackgroundColor: Color(0xffdfe0e1),
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff00b6ca),
          minimumSize: Size(200, 50),
          shape: StadiumBorder(),
        )
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Color(0xff00b6ca),
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        )
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 18,
      ),
      headline4: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Color(0xfff4a045),
      ),
    ),
  );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/home.dart';
import 'package:social_hackathon_umbria/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Social Hackathon",
      home: FirebaseAuth.instance.currentUser != null ? Home() : Login(),
      theme: _createTheme(),
      );

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

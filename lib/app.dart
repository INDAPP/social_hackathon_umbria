import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Social Hackathon",
        home: Login(),
        theme: _createTheme(),
      );

  ThemeData _createTheme() => ThemeData(
    primarySwatch: Colors.red,
    primaryColor: Colors.amber,
    accentColor: Colors.blue,
    scaffoldBackgroundColor: Color(0xffdfe0e1),
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
        color: Colors.red.shade800,
      ),
      bodyText2: TextStyle(
        fontSize: 24,
      ),
      headline4: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Color(0xfff4a045),
      ),
    ),
  );
}

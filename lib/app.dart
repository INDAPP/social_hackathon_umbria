import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Social Hackathon",
        home: Home(),
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.amber,
          accentColor: Colors.blue,
          scaffoldBackgroundColor: Colors.yellow.shade200,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey,
              minimumSize: Size(200, 50),
            )
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.green,
              textStyle: TextStyle(
                fontSize: 30,
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
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
}

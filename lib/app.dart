import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Social Hackathon",
        home: Home(),
        theme: ThemeData(primarySwatch: Colors.red),
      );
}
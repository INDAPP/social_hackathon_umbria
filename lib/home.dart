import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Hackathon"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Ciao"),
            Text("Social Hackathon"),
            Text("Mobile app"),
          ],
        ),
      ),
    );
  }
}

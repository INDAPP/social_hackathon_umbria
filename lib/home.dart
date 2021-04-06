import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int counter = 0;
  bool signupButtonVisible = true;
  String textFieldString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        title: Text("Social Hackathon"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text("Contatore"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$counter"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(textFieldString),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: 240,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Username",
                  //errorText: "Inserisci email",
                ),
                onChanged: (text) {
                  setState(() {
                    textFieldString = text;
                  });
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: Colors.red),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: signupButtonVisible,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("SignUp"),
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    //TODO: implementare pulsante login
                    setState(() {
                      signupButtonVisible = true;
                    });
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            counter++;
          });
        },
      ),
    );
  }
}

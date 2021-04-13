import 'package:flutter/material.dart';

const String myUsername = "Riccardo";
const String myPassword = "123456";

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
  String textFieldPassword = "";

  bool loginSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Hackathon"),
      ),
      body: Align(
        alignment: Alignment.lerp(Alignment.topCenter, Alignment.center, 0.25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: 240,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Contatore",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$counter",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: loginSuccess,
                      child: Text("Login effettuato!"),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      labelText: "Username",
                      //errorText: "Inserisci email",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      setState(() {
                        textFieldString = text;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Almeno 8 caratteri",
                      labelText: "Password",
                      //errorText: "Inserisci email",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    onChanged: (text) {
                      setState(() {
                        textFieldPassword = text;
                      });
                    },
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  border: Border.all(color: Colors.red),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 2),
                      blurRadius: 8,
                    ),
                  ]),
            ),
            SizedBox(
              height: 16,
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
                    setState(() {
                      loginSuccess = myUsername == textFieldString &&
                          myPassword == textFieldPassword;
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

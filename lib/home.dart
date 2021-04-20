import 'package:flutter/material.dart';

const String myUsername = "Riccardo";
const String myPassword = "123456";

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String textFieldString = "";
  String textFieldPassword = "";

  bool loginSuccess = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(context),
                _buildForm(context),
                _buildActions(context),
              ],
            ),
          ),
        ),
      );

  Widget _buildLogo(BuildContext context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Image.asset(
              "images/shu_logo.png",
              height: 180,
            ),
            SizedBox(height: 16),
            Text(
              "Social Hackathon Umbria",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  Widget _buildForm(BuildContext context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: _validateEmail,
              decoration: InputDecoration(
                labelText: "email",
              ),
            ),
            TextFormField(
              validator: _validatePassword,
              decoration: InputDecoration(
                labelText: "password",
              ),
            ),
          ],
        ),
      );

  Widget _buildActions(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _login,
              child: Text("Login"),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: _signup,
              child: Text("Signup"),
            ),
          ],
        ),
      );

  String? _validateEmail([String? email]) {
    if (email?.contains("@") == true)
      return null;
    else
      return "Inserire un'email valida";
  }

  String? _validatePassword([String? password]) {
    final length = password?.length ?? 0;
    if (length > 6)
      return null;
    else
      return "Inserire almeno 6 acratteri";
  }

  void _login() {
    //TODO: eseguire il login
  }

  void _signup() {}
}

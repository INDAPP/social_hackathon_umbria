import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/signup.dart';

const String myUsername = "Riccardo";
const String myPassword = "123456";

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
              height: 120,
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: _validateEmail,
                onSaved: (value) {
                  _email = value;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                validator: _validatePassword,
                onSaved: (value) {
                  _password = value;
                },
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),

            ],
          ),
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
      return "Inserire almeno 6 caratteri";
  }

  void _login() {
    final validated = _formKey.currentState?.validate() ?? false;
    if (validated) {
      _formKey.currentState?.save();

      final email = _email;
      final password = _password;

      print(email);
      print(password);
      //TODO: eseguire il login
    }
  }

  void _signup() {
    showDialog(context: context, builder: _buildSignupDialog);
  }

  Widget _buildSignupDialog(BuildContext context) => Signup();
}

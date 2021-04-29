import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formKey = GlobalKey();

  String? _name;
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text("SignUp"),
        content: _buildContent(context),
        actions: [
          TextButton(
            onPressed: _dismiss,
            child: Text("Back"),
          ),
          TextButton(
            onPressed: _signup,
            child: Text("SignUp"),
          ),
        ],
      );

  Widget _buildContent(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: _validateName,
              onSaved: (value) {
                _name = value;
              },
              decoration: InputDecoration(
                labelText: "Nome",
              ),
            ),
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
              onChanged: (value) {
                _password = value;
              },
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            TextFormField(
              validator: _validateConfirmPassword,
              decoration: InputDecoration(
                labelText: "Conferma Password",
              ),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  String? _validateName([String? name]) {
    final length = name?.length ?? 0;
    if (length > 3)
      return null;
    else
      return "Inserire almeno 3 caratteri";
  }

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

  String? _validateConfirmPassword([String? confirmPassword]) {
    if (_password == confirmPassword)
      return null;
    else
      return "Le password non corrispondono";
  }

  void _dismiss() {
    //TODO
  }

  void _signup() {
    final validated = _formKey.currentState?.validate() ?? false;
    if (validated) {
      _formKey.currentState?.save();
      final name = _name;
      final email = _email;
      final password = _password;

      print(name);
      print(email);
      print(password);
      //TODO: eseguire il login
    }
  }
}

import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
    //TODO: inserire textfields per nome, email, password e conferma password
    return Container();
  }

  void _dismiss() {
    //TODO
  }

  void _signup() {
    //TODO: validazione e salvataggio form
  }
}

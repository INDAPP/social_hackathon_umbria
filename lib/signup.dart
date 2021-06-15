import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/model_signup.dart';

class Signup extends StatefulWidget {
  final String? email;
  final String? password;

  const Signup({
    Key? key,
    this.email,
    this.password,
  }) : super(key: key);

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
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: _validateName,
              onSaved: (value) {
                _name = value;
              },
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            TextFormField(
              initialValue: widget.email,
              validator: _validateEmail,
              onSaved: (value) {
                _email = value;
              },
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextFormField(
              initialValue: widget.password,
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
                labelText: "Confirm Password",
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
    if (length >= 3)
      return null;
    else
      return "Enter at least 3 characters";
  }

  String? _validateEmail([String? email]) {
    if (email?.contains("@") == true)
      return null;
    else
      return "Enter a valid email";
  }

  String? _validatePassword([String? password]) {
    final length = password?.length ?? 0;
    if (length >= 6)
      return null;
    else
      return "Enter at least 6 characters";
  }

  String? _validateConfirmPassword([String? confirmPassword]) {
    if (_password == confirmPassword)
      return null;
    else
      return "Passwords do not match";
  }

  void _dismiss() {
    Navigator.of(context).pop();
  }

  void _signup() {
    final validated = _formKey.currentState?.validate() ?? false;
    if (validated) {
      _formKey.currentState?.save();
      final name = _name;
      final email = _email;
      final password = _password;

      final modelSignup = ModelSignup(
        name: name!,
        email: email!,
        password: password!,
      );

      Navigator.of(context).pop(modelSignup);
    }
  }
}

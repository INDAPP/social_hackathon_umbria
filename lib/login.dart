import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/home.dart';
import 'package:social_hackathon_umbria/model_signup.dart';
import 'package:social_hackathon_umbria/signup.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                controller: _emailController,
                validator: _validateEmail,
                onSaved: (value) {
                  _email = value;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                controller: _passwordController,
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

  Widget _buildSignupDialog(BuildContext context) => Signup(
    email: _emailController.text,
    password: _passwordController.text,
  );

  Widget _buildHomePage(BuildContext context) => Home();

  String? _validateEmail([String? email]) {
    if (email?.contains("@") == true)
      return null;
    else
      return "Inserire un'email valida";
  }

  String? _validatePassword([String? password]) {
    final length = password?.length ?? 0;
    if (length >= 6)
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

      if (email != null && password != null) {
        final future = FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // try {
        //   final credentials = await future;
        //   _onLoginSuccess(credentials);
        // } catch (e) {
        //   _onLoginError(e);
        // }

        future.then(_onLoginSuccess).catchError(_onLoginError);
      }
    }
  }

  void _signup() async {
    final future = showDialog<ModelSignup>(
      context: context,
      builder: _buildSignupDialog,
    );

    final modelSignup = await future;

    _onSignup(modelSignup);
  }

  void _goToHome() {
    final navigator = Navigator.of(context);
    final route = MaterialPageRoute(builder: _buildHomePage);
    navigator.pushReplacement(route);
  }

  void _onSignup(ModelSignup? modelSignup) {
    print("Valore restituito: $modelSignup");
    if (modelSignup != null) {
      final future = FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: modelSignup.email,
        password: modelSignup.password,
      );

      future
          .then((userCredentials) {
            final user = userCredentials.user;
            final future = user?.updateProfile(
              displayName: modelSignup.name,
            );
            return future;
          })
          .then(_onSignupSuccess)
          .catchError(_onLoginError);
    }
  }

  void _onLoginSuccess(UserCredential userCredential) {
    _goToHome();
  }

  void _onSignupSuccess(dynamic _) {
    _goToHome();
  }

  Future<Null> _onLoginError(dynamic error) async {
    print(error);
    if (error is FirebaseAuthException) {
      final message = error.message;

      final snackBar = SnackBar(
        content: Text(message ?? "An error occoured"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}

import 'package:flutter/cupertino.dart';

class App2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoApp(
        theme: CupertinoThemeData(),
        home: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text("Social Hackathon iOS"),
            trailing: CupertinoButton(
              child: Text("Login"),
              onPressed: () {},
              padding: EdgeInsets.zero,
            ),
          ),
          child: Center(
            child: Text("iPhone style"),
          ),
        ),
      );
}

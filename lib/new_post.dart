import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewPostState();
  }
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration.collapsed(
                  hintText: "Scrivi qui il tuo post...",
                  //TODO: (forse) Randomizza il testo suggerito
                ),
              ),
            ),
          ),
          Divider(
            height: 2,
          ),
          Container(
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: (){},
                    child: Text("Annulla"),
                  ),
                ),
                VerticalDivider(
                  width: 2,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: (){},
                    child: Text("Pubblica"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

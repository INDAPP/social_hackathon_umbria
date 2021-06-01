import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewPostState();
  }
}

class _NewPostState extends State<NewPost> {
  String _text = "";

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
                onChanged: _onTextChanged,

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
                    onPressed: _onCancel,
                    child: Text("Annulla"),
                  ),
                ),
                VerticalDivider(
                  width: 2,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: _text.isEmpty ? null : _onPublish,
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
  void _onTextChanged (String text){
   setState(() {
     _text = text;
   });
  }

  void _onCancel() {
    final navigator = Navigator.of(context);
    navigator.pop();
  }

  void _onPublish() {
    final navigator = Navigator.of(context);
    navigator.pop(_text);
  }
}

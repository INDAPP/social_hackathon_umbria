import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewPostState();
  }
}

class _NewPostState extends State<NewPost> {
  final _picker = ImagePicker();
  String _text = "";
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Nuovo Post"),
      actions: [
        IconButton(
          icon: Icon(Icons.add_a_photo_outlined),
          onPressed: _addPictureFromCamera,
        ),
        IconButton(
          icon: Icon(Icons.add_photo_alternate_outlined),
          onPressed: _addPictureFromGallery,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          if (_image != null)
            ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
              title: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: _removePicture,
                  child: Text("Rimuovi"),
                ),
              ),
            ),
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
                autofocus: true,
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

  void _addPictureFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addPictureFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _removePicture() {
    setState(() {
      _image = null;
    });
  }

  void _onTextChanged(String text) {
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

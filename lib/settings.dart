import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _picker = ImagePicker();
  late TextEditingController _displayNameController;
  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    final displayName = currentUser?.displayName;
    _imageUrl = currentUser?.photoURL;
    _displayNameController = TextEditingController(text: displayName);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
        title: Text("Settings"),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text("Save"),
          ),
        ],
      );

  Widget _buildBody(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 148,
              height: 148,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
                image: _imageFile != null
                    ? DecorationImage(
                        image: FileImage(_imageFile!),
                      )
                    : _imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(_imageUrl!),
                          )
                        : null,
              ),
              child: Opacity(
                opacity: 0.5,
                child: IconButton(
                  iconSize: 48,
                  onPressed: _pickImageFromGallery,
                  icon: Icon(Icons.add_photo_alternate_outlined),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _displayNameController,
              decoration: InputDecoration(
                labelText: "Display Name",
              ),
            ),
          ],
        ),
      );

  void _pickImageFromGallery() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _save() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    final imageFile = _imageFile;
    final displayName = _displayNameController.text;
    var imageUrl = _imageUrl;

    if (imageFile != null) {
      final ref = FirebaseStorage.instance
          .ref('users/${currentUser.uid}');
      await ref.putFile(imageFile);
      imageUrl = await ref.getDownloadURL();
    }

    await currentUser.updateProfile(
      photoURL: imageUrl,
      displayName: displayName,
    );

    Navigator.of(context).pop();
  }
}

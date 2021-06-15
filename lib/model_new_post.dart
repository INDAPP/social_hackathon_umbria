import 'dart:io';

class ModelNewPost {
  final String text;
  final File? imageFile;

  ModelNewPost({
    required this.text,
    this.imageFile,
  });
}

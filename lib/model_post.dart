import 'package:social_hackathon_umbria/model_user.dart';

class ModelPost {
  final String id;
  final DateTime date;
  final String authorId;
  final String? content;
  final String? imageUrl;
  final ModelUser? user;

  const ModelPost({
    required this.id,
    required this.date,
    required this.authorId,
    this.content,
    this.imageUrl,
    this.user,
  });
}

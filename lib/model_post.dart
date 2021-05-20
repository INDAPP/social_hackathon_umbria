import 'package:social_hackathon_umbria/model_user.dart';

class ModelPost {
  final String id;
  final DateTime date;
  final String authorId;
  final String? authorName;
  final String? authorImageUrl;
  final String? content;
  final String? imageUrl;

  const ModelPost({
    required this.id,
    required this.date,
    required this.authorId,
    this.authorName,
    this.authorImageUrl,
    this.content,
    this.imageUrl,
  });
}

class ModelPost {
  final String id;
  final DateTime date;
  final String authorId;
  final String? content;
  final String? imageUrl;

  const ModelPost({
    required this.id,
    required this.date,
    required this.authorId,
    this.content,
    this.imageUrl,
  });
}

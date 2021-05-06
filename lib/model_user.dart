class User {
  final String id;
  final String nickname;
  final String? imageUrl;

  User({
    required this.id,
    required this.nickname,
    this.imageUrl,
  });
}

class ModelUser {
  final String id;
  final String nickname;
  final String? imageUrl;

  ModelUser({
    required this.id,
    required this.nickname,
    this.imageUrl,
  });
}

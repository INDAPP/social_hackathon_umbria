import 'package:flutter/material.dart';
import 'package:social_hackathon_umbria/model_post.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
      );
}

List<ModelPost> _mockPosts = [
  ModelPost(
    id: "skdvbsfkv",
    date: DateTime(2020),
    authorId: "ksdvbvbws",
    content: "Primo post dell'Hackathon",
  ),
  ModelPost(
    id: "skdvbsfte",
    date: DateTime(2021),
    authorId: "ksdvbvbws",
    content: "Viva il Social Hackathon",
  ),
];

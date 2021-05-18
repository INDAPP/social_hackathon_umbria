import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_hackathon_umbria/login.dart';
import 'package:social_hackathon_umbria/model_post.dart';
import 'package:social_hackathon_umbria/model_user.dart';

enum MenuItemAction {
  logout,
  settings,
}

class Home extends StatelessWidget {
  final DateFormat _dateFormat = DateFormat.Hm().add_yMMMEd();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
        title: Text("Home"),
        actions: [
          // TextButton(
          //   onPressed: () => _logout(context),
          //   child: Text("Logout"),
          // ),
          PopupMenuButton<MenuItemAction>(
            itemBuilder: _buildMenu,
            child: Icon(Icons.more_vert),
            onSelected: (action) => _onMenuAction(context, action),
          ),
        ],
      );

  List<PopupMenuEntry<MenuItemAction>> _buildMenu(BuildContext context) => [
        PopupMenuItem(
          value: MenuItemAction.settings,
          child: Text("Settings"),
        ),
        PopupMenuItem(
          value: MenuItemAction.logout,
          child: Text("Logout"),
        ),
      ];

  Widget _buildBody(BuildContext context) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockPosts.length,
        itemBuilder: _buildPostCard,
      );

  Widget _buildPostCard(BuildContext context, int index) {
    final post = _mockPosts[index];
    return Padding(
      key: Key(post.id),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).unselectedWidgetColor,
                        image: DecorationImage(
                          image: NetworkImage(post.user?.imageUrl ?? ""),
                        ),
                      ),
                      //child: Image.network(post.user?.imageUrl ?? ""),
                    ),
                    SizedBox(width: 16),
                    Text(
                      post.user?.nickname ?? "Utente Anonimo",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.content!,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _dateFormat.format(post.date),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMenuAction(BuildContext context, MenuItemAction action) {
    switch (action) {
      case MenuItemAction.settings:
        //TODO
        break;
      case MenuItemAction.logout:
        _logout(context);
        break;
    }
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    final navigator = Navigator.of(context);
    final route = MaterialPageRoute(
      builder: (context) => Login(),
    );
    navigator.pushReplacement(route);
  }
}

List<ModelPost> _mockPosts = [
  ModelPost(
    id: "skdvbsfkv",
    date: DateTime(2020),
    authorId: "ksdvbvbws",
    content:
        "Primo post dell'Hackathon Primo post dell'Hackathon Primo post dell'Hackathon Primo post dell'Hackathon",
    user: ModelUser(
      id: "0001",
      nickname: "Riccardo",
      imageUrl:
          "https://scontent-mxp1-1.xx.fbcdn.net/v/t1.18169-1/p160x160/21106770_10213796302570902_9084681745243619287_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=dbb9e7&_nc_ohc=1qQmacXwVHIAX9JqN_r&_nc_ht=scontent-mxp1-1.xx&tp=6&oh=3a7282aedfe65ec722eef1f1b9a77b17&oe=60BADC9D",
    ),
  ),
  ModelPost(
    id: "skdvbsfte",
    date: DateTime(2021),
    authorId: "ksdvbvbws",
    content: "Viva il Social Hackathon",
    user: ModelUser(
      id: "0001",
      nickname: "Riccardo",
      imageUrl:
          "https://scontent-mxp1-1.xx.fbcdn.net/v/t1.18169-1/p160x160/21106770_10213796302570902_9084681745243619287_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=dbb9e7&_nc_ohc=1qQmacXwVHIAX9JqN_r&_nc_ht=scontent-mxp1-1.xx&tp=6&oh=3a7282aedfe65ec722eef1f1b9a77b17&oe=60BADC9D",
    ),
  ),
];

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final collection = FirebaseFirestore.instance.collection("posts");



  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) =>
      AppBar(
        title: Text("Home"),
        actions: [
          // TextButton(
          //   onPressed: () => _logout(context),
          //   child: Text("Logout"),
          // ),
          PopupMenuButton<MenuItemAction>(
            itemBuilder: _buildMenu,
            icon: Icon(Icons.more_vert),
            onSelected: (action) => _onMenuAction(context, action),
          ),
        ],
      );

  List<PopupMenuEntry<MenuItemAction>> _buildMenu(BuildContext context) =>
      [
        PopupMenuItem(
          value: MenuItemAction.settings,
          child: Text("Settings"),
        ),
        PopupMenuItem(
          value: MenuItemAction.logout,
          child: Text("Logout"),
        ),
      ];

  Widget _buildBody(BuildContext context) => FutureBuilder<QuerySnapshot>(
    future: collection.get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
          itemCount: snapshot.data?.size ?? 0,
          itemBuilder: (context, index) => Card(
            child: Text("POST"),
          ),
        );
      }
    },
  );
      // ListView.builder(
      //   padding: const EdgeInsets.all(16),
      //   //TODO itemCount: _mockPosts.length,
      //   itemBuilder: _buildPostCard,
      // );

  Widget _buildPostCard(BuildContext context, ModelPost post) {
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
                        color: Theme
                            .of(context)
                            .unselectedWidgetColor,
                        image: DecorationImage(
                          image: NetworkImage(post.authorImageUrl ?? ""),
                        ),
                      ),
                      //child: Image.network(post.user?.imageUrl ?? ""),
                    ),
                    SizedBox(width: 16),
                    Text(
                      post.authorName ?? "Utente Anonimo",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.content!,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _dateFormat.format(post.date),
                  textAlign: TextAlign.end,
                  style: Theme
                      .of(context)
                      .textTheme
                      .caption,
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
    final confirm = await showDialog<bool>(
      context: context, builder: _buildLogoutDialog,);

    if (confirm != true) return;

    await FirebaseAuth.instance.signOut();

    final navigator = Navigator.of(context);
    final route = MaterialPageRoute(
      builder: (context) => Login(),
    );
    navigator.pushReplacement(route);
  }

  Widget _buildLogoutDialog(BuildContext context) => AlertDialog(
    title: Text("Logout"),
    content: Text("Are you sure?"),
    actions: [
      TextButton(
        child: Text("Cancel"),
        onPressed: () => Navigator.of(context).pop(false),
      ),
      TextButton(
        child: Text("Logout"),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    ],
  );
}

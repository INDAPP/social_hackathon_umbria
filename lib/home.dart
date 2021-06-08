import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_hackathon_umbria/login.dart';
import 'package:social_hackathon_umbria/model_post.dart';
import 'package:social_hackathon_umbria/new_post.dart';
import 'package:social_hackathon_umbria/settings.dart';

enum MenuItemAction {
  logout,
  settings,
}

class Home extends StatelessWidget {
  final DateFormat _dateFormat = DateFormat.Hm().add_yMMMEd();
  final collection = FirebaseFirestore.instance.collection("posts");

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body: StreamBuilder<QuerySnapshot>(
          stream: collection.snapshots(),
          builder: _buildBody,
        ),
        floatingActionButton: _buildFab(context),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
        title: Image.asset(
          "images/shu_logo_2021.png",
          height: 40,
        ),
        actions: [
          PopupMenuButton<MenuItemAction>(
            itemBuilder: _buildMenu,
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
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

  Widget _buildBody(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return _buildError(context);
    } else if (snapshot.hasData) {
      return _buildList(context, snapshot.data!);
    } else {
      return _buildLoading(context);
    }
  }

  Widget _buildLoading(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildError(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Text(
          "Si è verificato un errore",
          textAlign: TextAlign.center,
        ),
      );

  Widget _buildList(BuildContext context, QuerySnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.size,
      itemBuilder: (context, index) {
        final doc = snapshot.docs[index];
        final post = ModelPost(
          id: doc.id,
          date: doc.get("date").toDate(),
          authorId: doc.get("authorId"),
          authorName: doc.get("authorName"),
          authorImageUrl: doc.get("authorImageUrl"),
          content: doc.get("content"),
          imageUrl: doc.get("imageUrl"),
        );
        return _buildPostCard(context, post);
      },
      padding: EdgeInsets.all(16),
    );
  }

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
                        color: Theme.of(context).unselectedWidgetColor,
                        image: DecorationImage(
                          image: NetworkImage(post.authorImageUrl ?? ""),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      post.authorName ?? "Utente Anonimo",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.content ?? "",
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

  Widget _buildFab(BuildContext context) => FloatingActionButton(
        onPressed: () => _onFabPressed(context),
        child: Icon(Icons.add),
      );

  void _onMenuAction(BuildContext context, MenuItemAction action) {
    switch (action) {
      case MenuItemAction.settings:
        _settings(context);
        break;
      case MenuItemAction.logout:
        _logout(context);
        break;
    }
  }

  void _onFabPressed(BuildContext context) async {
    final navigator = Navigator.of(context);
    final route = MaterialPageRoute<String>(
      builder: (context) => NewPost(),
    );
    final text = await navigator.push<String>(route);
    final user = FirebaseAuth.instance.currentUser;
    if (text != null && user != null) {
      await collection.add({
        "date": FieldValue.serverTimestamp(),
        "authorId": user.uid,
        "authorName": user.displayName,
        "authorImageUrl": user.photoURL,
        "content": text,
        "imageUrl": null,
      });
    }
  }

  void _settings(BuildContext context) {
    final navigator = Navigator.of(context);
    final route = MaterialPageRoute(
      builder: (context) => SettingsScreen(),
    );
    navigator.push(route);
  }

  void _logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: _buildLogoutDialog,
    );

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

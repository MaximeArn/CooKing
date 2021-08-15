import 'package:cooking/providers/users.dart';
import 'package:cooking/views/profiles/widgets/profile_header.dart';
import 'package:cooking/views/profiles/widgets/user_posts.dart';
import 'package:cooking/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OwnProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsersProvider usersProvider =
        Provider.of<UsersProvider>(context, listen: false);
    return FutureBuilder(
      future: usersProvider.getConnectedUser("60e8c2140e7c9296fa2380c3"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                ProfileHeader(
                  name: snapshot.data.name,
                  avatar: snapshot.data.avatar,
                  stars: snapshot.data.stars,
                  subscribers: snapshot.data.subscribers,
                  subscriptions: snapshot.data.subscriptions,
                ),
                UserPosts(posts: snapshot.data.posts)
              ],
            ),
          );
        } else {
          return Loader();
        }
      },
    );
  }
}
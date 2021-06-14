import 'package:cooking/data/data.dart';
import 'package:cooking/models/Post.type.dart';
import 'package:cooking/views/vote/widgets/post_card.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Feed> {
  late List<Post> postsList;

  @override
  void initState() {
    postsList = posts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemCount: postsList.length,
      itemBuilder: (context, index) => PostCard(post: postsList[index]),
      separatorBuilder: (context, index) => Divider(
        height: 25,
      ),
    );
  }
}
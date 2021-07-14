import 'package:cooking/models/Post.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String avatar;
  final List<Post> posts;
  final int stars;
  final int subscribers;
  final int subscriptions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
    required this.posts,
    required this.stars,
    required this.subscribers,
    required this.subscriptions,
  });

  User.fromJson(Map<String, dynamic> json, {bool isPopulated = true})
      : id = json["_id"],
        name = json["name"],
        email = json["email"],
        password = json["password"],
        avatar = json["avatar"],
        posts = isPopulated
            ? (json["posts"] as List).map((jsonPost) {
                return Post.fromJson(
                  jsonPost,
                  isPopulated: false,
                );
              }).toList()
            : [],
        stars = json["stars"],
        subscribers = json["subscribers"],
        subscriptions = json["subscriptions"];
}

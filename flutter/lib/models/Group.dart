import 'package:cooking/models/User.dart';

class Group {
  final List<User> users;
  final String name;

  Group({
    required this.users,
    required this.name,
  });

  Group.fromJson(json, {bool isPopulated = true}): 
    name = json["name"],
    users = [];
}
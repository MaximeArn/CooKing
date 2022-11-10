import 'package:cooking/environment/env.dart';
import 'package:flutter/material.dart';

class GroupListRow extends StatelessWidget {
  const GroupListRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String avatar = "default_avatar.jpg";
    final String title = "Group Title";

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1.7),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                margin: EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(assetsUrl + avatar),
                  radius: 35,
                ),
              ),
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Challenge",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(
                width: 75,
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              Text("Archive"),
            ],
          )
        ],
      ),
    );
  }
}

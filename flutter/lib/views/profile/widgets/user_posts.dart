import 'package:flutter/material.dart';

class UserPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 67,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text("Mes Plats :", style: TextStyle(fontSize: 18),),
                ),
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  children: 
                    List.generate(12, (index) => Container(alignment: Alignment.center, color: Colors.red , child: Text(index.toString()),)).toList()
                  ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

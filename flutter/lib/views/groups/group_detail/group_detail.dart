import 'package:cooking/models/Group.dart';
import 'package:cooking/widgets/scaffolds/secondary_scaffold.dart';
import 'package:flutter/material.dart';

class GroupDetail extends StatelessWidget {
  static const routeName = "/groupDetail";
  const GroupDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Group group = ModalRoute.of(context)!.settings.arguments as Group;

    return SecondaryScaffold(
      body: DefaultTabController(
        length: 2,
        child: Container(
          child: Column(
            children: [
              TabBar(
                unselectedLabelColor: Colors.black54,
                labelColor: Theme.of(context).highlightColor,
                indicatorColor: Theme.of(context).highlightColor,
                indicatorWeight: 2.5,
                tabs: [
                  Tab(
                    child: Text("Challenges"),
                  ),
                  Tab(
                    child: Text("Ranking"),
                  ),
                ],
              ),
              Expanded(
                flex:1,
                child: TabBarView(children: [
                  Center(
                    child: Text("Challenges"),
                  ),
                  Center(
                    child: Text("Ranking"),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

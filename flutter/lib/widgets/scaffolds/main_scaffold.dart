import 'package:cooking/views/edit_profile/edit_profile.dart';
import 'package:cooking/widgets/scaffolds/bottom_navigation.dart';
import 'package:cooking/widgets/scaffolds/cooking_app_bar.dart';
import 'package:cooking/widgets/drawer/cooking_drawer.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final int index;
  final void Function(int) setIndex;

  MainScaffold({
    required this.body,
    required this.index,
    required this.setIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: index == 4
          ? CookingAppBar(
              action: IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, EditProfile.routeName),
                icon: Icon(Icons.edit),
              ),
            )
          : index == 1
              ? CookingAppBar(
                  hasBottomShadow: false,
                )
              : CookingAppBar(),
      drawer: const CookingDrawer(),
      bottomNavigationBar: BottomNavigation(index: index, setIndex: setIndex),
      body: body,
    );
  }
}

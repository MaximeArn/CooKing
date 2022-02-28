import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final void Function(int) setIndex;
  final int index;

  const BottomNavigation({required this.setIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.touch_app,
          ),
          label: "vote",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: "rewards"),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "post"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "ranking"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "profile"),
      ],
      onTap: (newIndex) {
        setIndex(newIndex);
      },
    );
  }
}

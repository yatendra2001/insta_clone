import 'package:flutter/material.dart';
import 'package:insta_clone/enums/enums.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selected;
  final Function(int) onTap;

  const BottomNavBar(
      {Key? key,
      required this.items,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: BottomNavItem.values.indexOf(selected),
      onTap: onTap,
      items: items
          .map(
            (item, icon) => MapEntry(
              item.toString(),
              BottomNavigationBarItem(
                icon: Icon(icon, size: 30.0),
                label: '',
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({Key? key}) : super(key: key);

  static const String routeName = '/nav';

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const NavScreen(),
      transitionDuration: const Duration(seconds: 0),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Nav Screen'),
    );
  }
}

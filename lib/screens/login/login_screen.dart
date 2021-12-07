import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const LoginScreen(),
      transitionDuration: const Duration(seconds: 0),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Login Screen'),
    );
  }
}

import 'package:flutter/material.dart';

class CreatePostsScreen extends StatelessWidget {
  static const String routeName = '/createPosts';
  const CreatePostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('CreatePosts Screen'),
      ),
    );
  }
}

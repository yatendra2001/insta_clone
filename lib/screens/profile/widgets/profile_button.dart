import 'package:flutter/material.dart';
import 'package:insta_clone/screens/screens.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;
  const ProfileButton({
    Key? key,
    required this.isCurrentUser,
    required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
                EditProfileScreen.routeName,
                arguments: EditProfileScreenArgs(context: context)),
            child: const Text(
              'Edit Profile',
            ),
          )
        : TextButton(
            style: TextButton.styleFrom(
              backgroundColor: isFollowing
                  ? Colors.grey[300]
                  : Theme.of(context).primaryColor,
              primary: isFollowing ? Colors.black : Colors.white,
            ),
            onPressed: () {},
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: const TextStyle(fontSize: 16.0),
            ),
          );
  }
}

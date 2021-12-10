import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/blocs/auth/auth_bloc.dart';
import 'package:insta_clone/config/custom_router.dart';
import 'package:insta_clone/enums/enums.dart';
import 'package:insta_clone/repositories/user/user_repository.dart';
import 'package:insta_clone/screens/profile/bloc/profile_bloc.dart';
import 'package:insta_clone/screens/screens.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({Key? key, required this.navigatorKey, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
              builder: (context) => routeBuilders[initialRoute]!(context),
              settings: RouteSettings(name: tabNavigatorRoot))
        ];
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        return FeedScreen();
      case BottomNavItem.search:
        return SearchScreen();
      case BottomNavItem.create:
        return CreatePostsScreen();
      case BottomNavItem.notifications:
        return NotificationsScreen();
      case BottomNavItem.profile:
        return BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
              authBloc: context.read<AuthBloc>())
            ..add(
              ProfileLoadUser(userId: context.read<AuthBloc>().state.user!.uid),
            ),
          child: ProfileScreen(),
        );
    }
  }
}

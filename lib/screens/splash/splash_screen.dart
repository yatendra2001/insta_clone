import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/blocs/blocs.dart';
import 'package:insta_clone/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prevState, state) => prevState.status != state.status,
      listener: (context, state) {
        print(state);

        if (state.status == AuthStatus.unauthenticated) {
          // Go to Login Screen
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          // Go to Nav Screen
          Navigator.of(context).pushNamed(NavScreen.routeName);
        }
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

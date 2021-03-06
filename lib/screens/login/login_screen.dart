import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/repositories/auth/auth_repository.dart';
import 'package:insta_clone/screens/login/cubit/login_cubit.dart';
import 'package:insta_clone/screens/screens.dart';
import 'package:insta_clone/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: LoginScreen(),
      ),
      transitionDuration: const Duration(seconds: 0),
      settings: const RouteSettings(name: routeName),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(
                        content: state.failureModel.message,
                      ));
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset:
                  false, // When we toggle keyboard the widget wont shift up
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Instagram',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12.0),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .emailChanged(value),
                              validator: (value) => value!.contains('@')
                                  ? null
                                  : 'Please enter a valid email',
                            ),
                            const SizedBox(height: 12.0),
                            TextFormField(
                              obscureText: true,
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .passwordChanged(value),
                              validator: (value) => value!.length >= 6
                                  ? null
                                  : 'Must be atleast 6 characters',
                            ),
                            const SizedBox(height: 28.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 1.0,
                                  primary: Theme.of(context).primaryColor,
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                              onPressed: () => _submitForm(context,
                                  state.status == LoginStatus.submitting),
                              child: const Text('Log In'),
                            ),
                            const SizedBox(height: 12.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 1.0,
                                primary: Colors.grey[200],
                              ),
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(SignupScreen.routeName),
                              child: const Text('No account? Sign up',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}

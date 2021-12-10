import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/helpers/helpers.dart';

import 'package:insta_clone/models/user_model.dart';
import 'package:insta_clone/repositories/repositories.dart';
import 'package:insta_clone/screens/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:insta_clone/screens/profile/bloc/profile_bloc.dart';
import 'package:insta_clone/widgets/widgets.dart';

class EditProfileScreenArgs {
  final BuildContext context;
  const EditProfileScreenArgs({
    required this.context,
  });
}

class EditProfileScreen extends StatelessWidget {
  static const routeName = '/editProfile';

  static Route route({required EditProfileScreenArgs args}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<EditProfileCubit>(
        create: (_) => EditProfileCubit(
          userRepository: context.read<UserRepository>(),
          storageRepository: context.read<StorageRepository>(),
          profileBloc: args.context.read<ProfileBloc>(),
        ),
        child: EditProfileScreen(
            user: args.context.read<ProfileBloc>().state.user),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final User user;
  EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state.status == EditProfileStatus.success) {
              Navigator.of(context).pop();
            } else if (state.status == EditProfileStatus.error) {
              showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(content: state.failureModel.message),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (state.status == EditProfileStatus.submitting)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 32.0),
                  GestureDetector(
                    onTap: () => _selectProfileImage(context),
                    child: UserProfileImage(
                        radius: 80.0,
                        profileImageUrl: user.profileImageUrl,
                        profileImage: state.profileImage),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            initialValue: user.username,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                            ),
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .usernameChanged(value),
                            validator: (value) => value!.trim().isEmpty
                                ? 'Username cannot be empty.'
                                : null,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            initialValue: user.bio,
                            decoration: const InputDecoration(
                              hintText: 'Bio',
                            ),
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .bioChanged(value),
                            validator: (value) => value!.trim().isEmpty
                                ? 'Bio cannot be empty.'
                                : null,
                          ),
                          const SizedBox(height: 28.0),
                          ElevatedButton(
                            onPressed: () => _submitForm(context,
                                state.status == EditProfileStatus.submitting),
                            child: const Text('Update'),
                            style: ElevatedButton.styleFrom(
                              elevation: 1.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _selectProfileImage(BuildContext context) async {
    final pickedFile = await ImageHelper.pickFromGallery(
        context: context, cropStyle: CropStyle.circle, title: 'Profile Image');
    if (pickedFile != null) {
      context
          .read<EditProfileCubit>()
          .profileImageChanged(File(pickedFile.path));
    }
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<EditProfileCubit>().submit();
    }
  }
}

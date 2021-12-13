import 'package:flutter/material.dart';
import 'package:insta_clone/screens/profile/widgets/widgets.dart';
import 'package:insta_clone/screens/screens.dart';
import 'package:insta_clone/screens/search/cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/widgets/user_profile_image.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textController,
          decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: InputBorder.none,
            hintText: 'Search Users',
            suffixIcon: IconButton(
              onPressed: () {
                context.read<SearchCubit>().clearSearch();
                _textController.clear();
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          onSubmitted: (value) {
            context.read<SearchCubit>().searchUsers(query: value.trim());
          },
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          switch (state.status) {
            case (SearchStatus.error):
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    state.failure.message,
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            case (SearchStatus.loading):
              return const Center(
                child: CircularProgressIndicator(),
              );
            case (SearchStatus.loaded):
              return state.users.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        final user = state.users[index];
                        return ListTile(
                          leading: UserProfileImage(
                            profileImageUrl: user.profileImageUrl,
                            radius: 22.0,
                          ),
                          title: Text(
                            user.username,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          onTap: () => Navigator.of(context).pushNamed(
                            ProfileScreen.routeName,
                            arguments: ProfileScreenArgs(userId: user.id),
                          ),
                        );
                      },
                    )
                  : const CenteredText(text: 'No users found');
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

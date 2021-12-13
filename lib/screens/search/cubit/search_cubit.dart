import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_clone/models/models.dart';
import 'package:insta_clone/repositories/repositories.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository _userRepository;
  SearchCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SearchState.initial());

  void searchUsers({required String query}) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final users = await _userRepository.searchUsers(query: query);
      emit(state.copyWith(users: users, status: SearchStatus.loaded));
    } catch (err) {
      state.copyWith(
        status: SearchStatus.error,
        failure: const FailureModel(
            message: 'Something went wrong. Please try again.'),
      );
    }
  }

  void clearSearch() {
    emit(state.copyWith(users: [], status: SearchStatus.initial));
  }
}

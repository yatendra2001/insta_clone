import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_clone/enums/enums.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit()
      : super(const BottomNavBarState(selected: BottomNavItem.feed));

  void updateSelectedItem(BottomNavItem item) {
    if (item != state.selected) {
      emit(BottomNavBarState(selected: item));
    }
  }
}

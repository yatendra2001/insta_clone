part of 'bottom_nav_bar_cubit.dart';

class BottomNavBarState extends Equatable {
  final BottomNavItem selected;

  const BottomNavBarState({required this.selected});

  @override
  List<Object> get props => [selected];
}

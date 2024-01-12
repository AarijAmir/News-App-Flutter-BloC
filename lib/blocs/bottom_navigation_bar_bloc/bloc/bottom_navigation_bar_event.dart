part of 'bottom_navigation_bar_bloc.dart';

@immutable
abstract class BottomNavigationBarEvent {}

class HomeBottomNavigationBarEvent extends BottomNavigationBarEvent{}
class SourcesBottomNavigationBarEvent extends BottomNavigationBarEvent{}
class SearchBottomNavigationBarEvent extends BottomNavigationBarEvent{}
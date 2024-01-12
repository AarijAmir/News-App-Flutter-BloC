import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_bar_event.dart';
part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarBloc
    extends Bloc<BottomNavigationBarEvent, BottomNavigationBarState> {
  BottomNavigationBarBloc() : super(const HomeBottomNavigationBarState()) {
    on<BottomNavigationBarEvent>((event, emit) {
      if (event is HomeBottomNavigationBarEvent) {
        emit(const HomeBottomNavigationBarState());
      } else if (event is SourcesBottomNavigationBarEvent) {
        emit(const SourcesBottomNavigationBarState());
      } else if (event is SearchBottomNavigationBarEvent) {
        emit(const SearchBottomNavigationBarState());
      }
    });
  }
}

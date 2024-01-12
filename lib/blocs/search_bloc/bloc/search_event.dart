part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class FoundedSearchEvent extends SearchEvent {}

class NotFoundSearchEvent extends SearchEvent {}

class FoundSearchEvent extends SearchEvent {
  final String searchValue;
  const FoundSearchEvent(this.searchValue);
}

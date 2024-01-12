part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class InitialSearchState extends SearchState {
  const InitialSearchState();
}

class FoundedSearchState extends SearchState {
  final ArticleResponse articleResponse;
  const FoundedSearchState(this.articleResponse);
}

class NotFoundSearchState extends SearchState {
  const NotFoundSearchState();
}

class FoundSearchState extends SearchState {
  const FoundSearchState();
}

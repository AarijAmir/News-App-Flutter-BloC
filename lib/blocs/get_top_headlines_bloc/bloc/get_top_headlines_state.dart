part of 'get_top_headlines_bloc.dart';

abstract class GetTopHeadlinesState {
  const GetTopHeadlinesState();
}

class InitialGetTopHeadlinesState extends GetTopHeadlinesState {
  const InitialGetTopHeadlinesState();
}

class LoadGetTopHeadlinesState extends GetTopHeadlinesState {
  const LoadGetTopHeadlinesState();
}

class LoadingGetTopHeadlinesState extends GetTopHeadlinesState {
  const LoadingGetTopHeadlinesState();
}

class LoadedGetTopHeadlinesState extends GetTopHeadlinesState {
  final ArticleResponse sourcesNews;
  const LoadedGetTopHeadlinesState(this.sourcesNews);
}

class NotLoadedGetTopHeadlinesState extends GetTopHeadlinesState {
  const NotLoadedGetTopHeadlinesState();
}

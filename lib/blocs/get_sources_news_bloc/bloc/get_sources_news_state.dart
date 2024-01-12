part of 'get_sources_news_bloc.dart';

abstract class GetSourcesNewsState {
  const GetSourcesNewsState();
}

class InitialGetSourcesNewsState extends GetSourcesNewsState {
  const InitialGetSourcesNewsState();
}

class LoadGetSourcesNewsState extends GetSourcesNewsState {
  const LoadGetSourcesNewsState();
}

class LoadingGetSourcesNewsState extends GetSourcesNewsState {
  const LoadingGetSourcesNewsState();
}

class LoadedGetSourcesNewsState extends GetSourcesNewsState {
  final ArticleResponse sourcesNews;
  const LoadedGetSourcesNewsState(this.sourcesNews);
}

class NotLoadedGetSourcesNewsState extends GetSourcesNewsState {
  const NotLoadedGetSourcesNewsState();
}

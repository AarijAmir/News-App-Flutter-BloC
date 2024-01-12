part of 'get_hot_news_bloc.dart';

@immutable
abstract class GetHotNewsState {
  const GetHotNewsState();
}

class InitialGetHotNewsState extends GetHotNewsState {
  const InitialGetHotNewsState();
}

class LoadingGetHotNewsState extends GetHotNewsState {
  const LoadingGetHotNewsState();
}

class LoadGetHotNewsState extends GetHotNewsState {
  const LoadGetHotNewsState();
}

class LoadedGetHotNewsState extends GetHotNewsState {
  final ArticleResponse hotNews;
  const LoadedGetHotNewsState(this.hotNews);
}

class NotLoadedGetHotNewsState extends GetHotNewsState {
  const NotLoadedGetHotNewsState();
}

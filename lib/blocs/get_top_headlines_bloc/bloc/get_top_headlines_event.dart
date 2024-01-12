part of 'get_top_headlines_bloc.dart';

@immutable
abstract class GetTopHeadlinesEvent {}

class LoadingGetTopHeadlinesEvent extends GetTopHeadlinesEvent {}

class LoadedGetTopHeadlinesEvent extends GetTopHeadlinesEvent {}

class NotLoadedGetTopHeadlinesEvent extends GetTopHeadlinesEvent {}

class LoadGetTopHeadLinesEvent extends GetTopHeadlinesEvent {}

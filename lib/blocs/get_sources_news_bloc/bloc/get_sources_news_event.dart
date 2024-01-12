part of 'get_sources_news_bloc.dart';

@immutable
abstract class GetSourcesNewsEvent {}

class LoadingGetSourcesNewsEvent extends GetSourcesNewsEvent {}

class LoadedGetSourcesNewsEvent extends GetSourcesNewsEvent {}

class NotLoadedGetSourcesNewsEvent extends GetSourcesNewsEvent {}

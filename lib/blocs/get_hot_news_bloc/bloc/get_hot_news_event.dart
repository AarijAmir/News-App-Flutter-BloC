part of 'get_hot_news_bloc.dart';

@immutable
abstract class GetHotNewsBlocEvent {}

class LoadGetHotNewsEvent extends GetHotNewsBlocEvent {}

class LoadingGetHotNewsEvent extends GetHotNewsBlocEvent {}

class LoadedGetHotNewsEvent extends GetHotNewsBlocEvent {}

class NotLoadedGetHotNewsEvent extends GetHotNewsBlocEvent {}

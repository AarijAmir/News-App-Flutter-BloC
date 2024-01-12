part of 'get_sources_bloc.dart';

@immutable
abstract class GetSourcesEvent {}

class LoadGetSourcesEvent extends GetSourcesEvent {}

class LoadingGetSourcesEvent extends GetSourcesEvent {}

class LoadedGetSourcesEvent extends GetSourcesEvent {}

class NotLoadedGetSourcesEvent extends GetSourcesEvent {}

part of 'get_sources_bloc.dart';

@immutable
abstract class GetSourcesState {
  const GetSourcesState();
}

class InitialGetSourcesState extends GetSourcesState {
  const InitialGetSourcesState();
}

class LoadGetSourcesState extends GetSourcesState {
  const LoadGetSourcesState();
}

class LoadingGetSourcesState extends GetSourcesState {
  const LoadingGetSourcesState();
}

class LoadedGetSourcesState extends GetSourcesState {
  final SourceResponse sourceResponse;
  const LoadedGetSourcesState(this.sourceResponse);
}

class NotLoadedGetSourcesState extends GetSourcesState {
  const NotLoadedGetSourcesState();
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/repository/repository.dart';

part 'get_sources_event.dart';
part 'get_sources_state.dart';

class GetSourcesBloc extends Bloc<GetSourcesEvent, GetSourcesState> {
   NewsRepository? _newsRepository = NewsRepository();
  GetSourcesBloc() : super(const InitialGetSourcesState()) {
    on<GetSourcesEvent>((event, emit) async {
      emit.call(const LoadingGetSourcesState());
      SourceResponse sources = await _newsRepository!.getSources;
      emit.call(LoadedGetSourcesState(sources));
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    _newsRepository = null;
    return super.close();
  }
}

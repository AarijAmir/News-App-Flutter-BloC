import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/article_response.dart';
import '../../../repository/repository.dart';

part 'get_sources_news_event.dart';
part 'get_sources_news_state.dart';

class GetSourcesNewsBloc extends Bloc<GetSourcesNewsEvent, GetSourcesNewsState> {
   NewsRepository? _newsRepository = NewsRepository();
  GetSourcesNewsBloc() : super(const InitialGetSourcesNewsState()) {
    on<GetSourcesNewsEvent>((event, emit) async {
      // TODO: implement event handler
      emit.call(const LoadingGetSourcesNewsState());
      ArticleResponse sourcesNews = await _newsRepository!.getHotNews;
      emit.call(LoadedGetSourcesNewsState(sourcesNews));
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    _newsRepository = null;
    return super.close();
  }
}

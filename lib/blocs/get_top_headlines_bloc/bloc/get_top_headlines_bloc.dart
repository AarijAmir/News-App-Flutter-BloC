import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/article_response.dart';
import '../../../repository/repository.dart';

part 'get_top_headlines_event.dart';
part 'get_top_headlines_state.dart';

class GetTopHeadlinesBloc
    extends Bloc<GetTopHeadlinesEvent, GetTopHeadlinesState> {
  final NewsRepository _newsRepository = NewsRepository();

  GetTopHeadlinesBloc() : super(const InitialGetTopHeadlinesState()) {
    on<GetTopHeadlinesEvent>((event, emit) async {
      emit.call(const LoadingGetTopHeadlinesState());
      ArticleResponse sourcesNews = await _newsRepository.getTopHeadlines;
      emit.call(LoadedGetTopHeadlinesState(sourcesNews));
    });
  }
}

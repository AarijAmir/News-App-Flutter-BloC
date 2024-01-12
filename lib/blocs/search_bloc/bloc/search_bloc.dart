import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/article_response.dart';
import '../../../repository/repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  NewsRepository? _newsRepository = NewsRepository();

  SearchBloc() : super(const InitialSearchState()) {
    on<SearchEvent>((event, emit) async {
      // TODO: implement event handler
      emit.call(const FoundSearchState());
      ArticleResponse article = await _newsRepository!
          .search((event as FoundSearchEvent).searchValue);
      emit.call(FoundedSearchState(article));
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    _newsRepository = null;
    return super.close();
  }
}

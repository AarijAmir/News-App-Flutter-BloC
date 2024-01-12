import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/repository/repository.dart';

part 'get_hot_news_event.dart';
part 'get_hot_news_state.dart';

class GetHotNewsBloc extends Bloc<GetHotNewsBlocEvent, GetHotNewsState> {
  NewsRepository? _newsRepository = NewsRepository();
  GetHotNewsBloc() : super(const InitialGetHotNewsState()) {
    on<GetHotNewsBlocEvent>((event, emit) async {
      // TODO: implement event handler
      emit.call(const LoadingGetHotNewsState());
      ArticleResponse hotNews = await _newsRepository!.getHotNews;
      emit.call(LoadedGetHotNewsState(hotNews));
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    _newsRepository = null;
    return super.close();
  }
}

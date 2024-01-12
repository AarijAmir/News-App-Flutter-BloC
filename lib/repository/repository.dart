import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source_response.dart';

import '../apis/news_api.dart';

class NewsRepository {
  NewsRepository() : _newsAPI = NewsAPI();
  final NewsAPI _newsAPI;
  Future<SourceResponse> get getSources async => await _newsAPI.sources;

  Future<ArticleResponse> get getTopHeadlines async =>
      await _newsAPI.topHeadlines;

  Future<ArticleResponse> get getHotNews async => await _newsAPI.hotNews;

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    return await _newsAPI.getSourceNews(sourceId);
  }

  Future<ArticleResponse> search(String searchValue) async {
    return await _newsAPI.search(searchValue);
  }
}

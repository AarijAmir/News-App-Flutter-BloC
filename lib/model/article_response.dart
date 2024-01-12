import 'package:news_app/model/article.dart';

class ArticleResponse {
  final List<Article> articlesList;
  String error;
  ArticleResponse(this.articlesList, this.error);
  ArticleResponse.fromMap(Map<String, dynamic> map)
      : articlesList =
            (map['articles'] as List).map((e) => Article.fromMap(e)).toList(),
        error = '';
  ArticleResponse.withError(String errorValue)
      : articlesList = [],
        error = errorValue;
}

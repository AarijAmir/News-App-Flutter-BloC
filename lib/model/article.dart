import 'package:news_app/model/source.dart';

class Article {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? img;
  final String? date;
  final String? content;
  final Source source;
  Article({
    required this.source,
    required this.author,
    required this.content,
    required this.date,
    required this.description,
    required this.img,
    required this.title,
    required this.url,
  });
  Article.fromMap(Map<String, dynamic> map)
      : source = Source.fromMap(
          map['source'],
        ),
        author = map['author'],
        title = map['title'],
        url = map['url'],
        img = map['urlToImage'],
        description = map['description'],
        date = map['publishedAt'],
        content = map['content'];
}

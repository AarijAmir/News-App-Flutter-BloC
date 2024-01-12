import 'package:news_app/model/source.dart';

class SourceResponse {
  final List<Source> sourcesList;
  String error;
  SourceResponse(this.sourcesList, this.error);
  SourceResponse.fromMap(Map<String, dynamic> map)
      : sourcesList =
            (map['sources'] as List).map((e) => Source.fromMap(e)).toList(),
        error = '';
  SourceResponse.withError(String errorValue)
      : sourcesList = [],
        error = errorValue;
}

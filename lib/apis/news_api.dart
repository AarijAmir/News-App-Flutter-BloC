import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants/url.dart';
import '../model/article_response.dart';
import '../model/source_response.dart';

class NewsAPI {
  final Dio _dio = Dio();
  NewsAPI() {
    _dio.options.baseUrl = mainUrl;
  }
  Future<SourceResponse> get sources async {
    var params = {'apiKey': apiKey, 'language': 'en', 'country': 'us'};
    try {
      Response response =
          await _dio.get(getSourcesUrl, queryParameters: params);

      return SourceResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Error: $error, StackTrace: $stackTrace');
      return SourceResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> get topHeadlines async {
    var params = {'apiKey': apiKey, 'country': 'us'};
    try {
      Response response = await _dio.get(
        getTopHeadLinesUrl,
        queryParameters: params,
      );

      return ArticleResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Error: $error, StackTrace: $stackTrace');
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> get hotNews async {
    var params = {'apiKey': apiKey, 'q': 'apple', 'sortBy': 'popularity'};
    try {
      Response response = await _dio.get(
        getEveryThingUrl,
        queryParameters: params,
      );
      return ArticleResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Error: $error, StackTrace: $stackTrace');
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {'apiKey': apiKey, 'sources': sourceId};
    try {
      Response response = await _dio.get(
        getTopHeadLinesUrl,
        queryParameters: params,
      );
      return ArticleResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Error: $error, StackTrace: $stackTrace');
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> search(String searchValue) async {
    var params = {'apiKey': apiKey, 'q': searchValue, 'sortBy': 'popularity'};
    try {
      Response response = await _dio.get(
        getEveryThingUrl,
        queryParameters: params,
      );
      print(response.data);
      return ArticleResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Error: $error, StackTrace: $stackTrace');
      return ArticleResponse.withError(error.toString());
    }
  }
}

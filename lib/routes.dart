import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/bottom_navigation_bar_bloc/bloc/bottom_navigation_bar_bloc.dart';
import 'package:news_app/blocs/get_hot_news_bloc/bloc/get_hot_news_bloc.dart';
import 'package:news_app/blocs/get_sources_bloc/bloc/get_sources_bloc.dart';
import 'package:news_app/blocs/get_sources_news_bloc/bloc/get_sources_news_bloc.dart';
import 'package:news_app/blocs/get_top_headlines_bloc/bloc/get_top_headlines_bloc.dart';
import 'package:news_app/blocs/search_bloc/bloc/search_bloc.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:news_app/screens/news_detail.dart';
import 'package:news_app/screens/source_detail.dart';
import 'package:news_app/screens/tabs/search_screen.dart';
import 'package:news_app/utils/constants.dart';

class RouteGenerator {
  static final BottomNavigationBarBloc _bottomNavigationBarBloc =
      BottomNavigationBarBloc();
  static final GetHotNewsBloc _getHotNewsBloc = GetHotNewsBloc();
  static final GetSourcesBloc _getSourcesBloc = GetSourcesBloc();
  static final GetSourcesNewsBloc _getSourcesNewsBloc = GetSourcesNewsBloc();
  static final SearchBloc _searchBloc = SearchBloc();
  static final GetTopHeadlinesBloc _getTopHeadlinesBloc = GetTopHeadlinesBloc();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kMainPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _getSourcesNewsBloc,
            child: BlocProvider.value(
              value: _searchBloc,
              child: BlocProvider.value(
                value: _getSourcesBloc,
                child: BlocProvider.value(
                  value: _getHotNewsBloc,
                  child: BlocProvider.value(
                    value: _bottomNavigationBarBloc,
                    child: BlocProvider.value(
                      value: _getTopHeadlinesBloc,
                      child: const MainScreen(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      case kSourceDetailPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _getSourcesNewsBloc,
            child: SourceDetail(source: settings.arguments as Source),
          ),
        );
      case kNewsDetailPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _getSourcesNewsBloc,
            child: NewsDetail(article: settings.arguments as Article),
          ),
        );
      case kSearchPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _searchBloc,
            child: const SearchScreen(),
          ),
        );
      default:
        throw 'Route Not Found...';
    }
  }
}

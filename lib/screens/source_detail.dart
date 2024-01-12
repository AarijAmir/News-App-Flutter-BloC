import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/get_sources_news_bloc/bloc/get_sources_news_bloc.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/style/theme.dart';
import 'package:news_app/utils/constants.dart';
import 'package:timeago/timeago.dart';

import '../blocs/get_top_headlines_bloc/bloc/get_top_headlines_bloc.dart';
import '../elements/error_element.dart';
import '../elements/loader_element.dart';

class SourceDetail extends StatefulWidget {
  final Source source;
  const SourceDetail({required this.source, Key? key}) : super(key: key);

  @override
  State<SourceDetail> createState() => _SourceDetailState();
}

class _SourceDetailState extends State<SourceDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetSourcesNewsBloc>(context, listen: false)
        .add(LoadedGetSourcesNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          40.0,
        ),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: ThemeColors.mainColor,
          title: const Text(''),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
              bottom: size.height * 0.025,
            ),
            color: ThemeColors.mainColor,
            width: size.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width * 0.03),
                  child: Hero(
                    tag: widget.source.id ?? '',
                    child: SizedBox(
                      height: size.width * 0.2,
                      width: size.width * 0.2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Colors.white,
                          ),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/logos/${widget.source.id}.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  widget.source.name ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(
                  widget.source.description ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.03,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<GetSourcesNewsBloc, GetSourcesNewsState>(
              builder: (context, state) {
                if (state is LoadedGetSourcesNewsState) {
                  if (state.sourcesNews.error.isNotEmpty) {
                    return buildErrorWidget(
                      state.sourcesNews.error,
                    );
                  }
                  print('Called Loaded');
                  return _buildSourcesNews(data: state.sourcesNews, size: size);
                } else if (state is NotLoadedGetTopHeadlinesState) {
                  return buildErrorWidget('Nothing Loaded');
                } else {
                  return buildLoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcesNews(
      {required ArticleResponse data, required Size size}) {
    List<Article> listOfArticles = data.articlesList
        .where((element) => !element.img!.contains('i.kinja-img.com'))
        .toList();
    if (listOfArticles.isEmpty) {
      return SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'No Articles',
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: listOfArticles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                kNewsDetailPage,
                arguments: listOfArticles[index],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 1.0),
                ),
              ),
              height: size.height * 0.17,
              child: Row(
                children: [
                  Container(
                    width: size.width * 3 / 5,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          listOfArticles[index].title ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size.width * 0.03,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Text(
                                  timeAgo(
                                    DateTime.parse(
                                      listOfArticles[index].date ?? '',
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.02,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: size.width * 0.01,
                    ),
                    width: size.width * 2 / 5,
                    height: size.height * 0.15,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.jpg',
                      image: listOfArticles[index].img == null
                          ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png'
                          : listOfArticles[index].img!,
                      fit: BoxFit.fitHeight,
                      width: double.maxFinite,
                      height: size.height * 1 / 3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  String timeAgo(DateTime date) {
    return format(
      date,
      allowFromNow: true,
      locale: 'en',
    );
  }
}

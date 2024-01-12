import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/get_hot_news_bloc/bloc/get_hot_news_bloc.dart';
import 'package:news_app/style/theme.dart';
import 'package:timeago/timeago.dart';

import '../elements/error_element.dart';
import '../elements/loader_element.dart';
import '../model/article.dart';
import '../model/article_response.dart';
import '../utils/constants.dart';

class HotNews extends StatefulWidget {
  const HotNews({super.key});

  @override
  State<HotNews> createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetHotNewsBloc>(context, listen: false)
        .add(LoadGetHotNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetHotNewsBloc, GetHotNewsState>(
      builder: (context, state) {
        if (state is LoadedGetHotNewsState) {
          if (state.hotNews.error.isNotEmpty) {
            return buildErrorWidget(
              state.hotNews.error,
            );
          }
          return _buildHotNewsWidget(
            response: state.hotNews,
            size: size,
          );
        } else if (state is NotLoadedGetHotNewsState) {
          return buildErrorWidget('Nothing Loaded');
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHotNewsWidget(
      {required ArticleResponse response, required Size size}) {
    List<Article> articles = response.articlesList
        .where((element) => !element.img!.contains('i.kinja-img.com'))
        .toList();

    if (articles.isEmpty) {
      return const Center(
        child: Text(
          "No more news",
          style: TextStyle(color: Colors.black45),
        ),
      );
    } else {
      return Container(
        height: size.height * 0.1371 * articles.length.toDouble(),
        width: size.width,
        padding: EdgeInsets.all(size.width * 0.01),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.03,
                  right: size.width * 0.03,
                  top: size.height * 0.01),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    kNewsDetailPage,
                    arguments: articles[index],
                  );
                },
                child: Container(
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: const Offset(
                          1.0,
                          1.0,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)),
                              image: (articles[index].img == null)
                                  ? const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/placeholder.jpg"),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: NetworkImage(
                                          articles[index].img.toString()),
                                      fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: size.height * 0.01,
                          right: size.height * 0.01,
                          top: size.height * 0.020,
                          bottom: size.height * 0.020,
                        ),
                        child: Text(
                          articles[index].title ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: size.width * 0.01,
                              right: size.width * 0.01,
                            ),
                            width: size.width,
                            height: size.width * 0.002,
                            color: Colors.black12,
                          ),
                          Container(
                            width: size.width * 0.08,
                            height: size.width * 0.005,
                            color: ThemeColors.mainColor,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              articles[index].source.name ?? '',
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: size.width * 0.020,
                              ),
                            ),
                            Text(
                              timeUntil(
                                DateTime.parse(
                                  articles[index].date ?? '',
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: size.width * 0.020,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  String timeUntil(DateTime date) {
    return format(date, allowFromNow: true, locale: 'en');
  }
}

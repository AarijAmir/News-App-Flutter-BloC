import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/get_top_headlines_bloc/bloc/get_top_headlines_bloc.dart';
import 'package:news_app/elements/error_element.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/utils/constants.dart';
import 'package:timeago/timeago.dart';

class HeadLineSliderWidget extends StatefulWidget {
  const HeadLineSliderWidget({super.key});

  @override
  State<HeadLineSliderWidget> createState() => _HeadLineSliderWidgetState();
}

class _HeadLineSliderWidgetState extends State<HeadLineSliderWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<GetTopHeadlinesBloc>(context, listen: false)
        .add(LoadGetTopHeadLinesEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetTopHeadlinesBloc, GetTopHeadlinesState>(
      builder: (context, state) {
        if (state is LoadedGetTopHeadlinesState) {
          if (state.sourcesNews.error.isNotEmpty) {
            return buildErrorWidget(
              state.sourcesNews.error,
            );
          }
          return _buildHeadLineSlider(data: state.sourcesNews, size: size);
        } else if (state is NotLoadedGetTopHeadlinesState) {
          return buildErrorWidget('Nothing Loaded');
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHeadLineSlider({
    required ArticleResponse data,
    required Size size,
  }) {
    List<Article> listOfArticles = data.articlesList;
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        reverse: true,
        enlargeCenterPage: false,
        height: size.height * 0.2,
        viewportFraction: 0.8,
      ),
      items: _getExpenseSlider(listOfArticles: listOfArticles, size: size),
    );
  }

  List<GestureDetector> _getExpenseSlider(
      {required List<Article> listOfArticles, required Size size}) {
    return listOfArticles.map(
      (article) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              kNewsDetailPage,
              arguments: article,
            );
          },
          child: Container(
            padding: EdgeInsets.only(
              left: size.width * 0.01,
              right: size.width * 0.01,
              top: size.height * 0.01,
              bottom: size.height * 0.01,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    shape: BoxShape.rectangle,
                    image: (article.img == null ||
                            article.img == 'i.kinja-img.com')
                        ? const DecorationImage(
                            image: AssetImage(
                              'assets/images/placeholder.jpg',
                            ),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(article.img!),
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.white.withOpacity(0.0),
                      ],
                      stops: const [0.1, 0.9],
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.03,
                        right: size.width * 0.03,
                        bottom: size.height * 0.04),
                    child: SizedBox(
                      height: size.height * 0.175,
                      width: size.width * 0.8,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          article.title ?? '',
                          maxLines: 5,
                          style: const TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.01,
                  left: size.width * 0.03,
                  child: Text(
                    article.source.name ?? '',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: size.width * 0.0175,
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.01,
                  right: size.width * 0.03,
                  child: Text(
                    timeAgo(
                      DateTime.parse(article.date!),
                    ),
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: size.width * 0.0175,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).toList();
  }

  String timeAgo(DateTime date) {
    return format(
      date,
      allowFromNow: true,
      locale: 'en',
    );
  }
}

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/search_bloc/bloc/search_bloc.dart';
import 'package:news_app/style/theme.dart';
import 'package:timeago/timeago.dart';

import '../../elements/error_element.dart';
import '../../elements/loader_element.dart';
import '../../model/article.dart';
import '../../model/article_response.dart';
import '../../utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.text = 'all';
    BlocProvider.of<SearchBloc>(context, listen: false)
        .add(FoundSearchEvent(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(size.width * 0.01),
          child: TextFormField(
            style: TextStyle(
              fontSize: size.width * 0.04,
              color: Colors.black,
            ),
            controller: _controller,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey.shade100,
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(
                          () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _controller.clear();
                            searchBloc.add(const FoundSearchEvent('all'));
                          },
                        );
                      },
                      icon: const Icon(EvaIcons.backspaceOutline))
                  : Icon(
                      EvaIcons.searchOutline,
                      color: Colors.grey.shade500,
                      size: size.width * 0.04,
                    ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade100.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(
                  size.width * 0.05,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade100.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(
                  size.width * 0.05,
                ),
              ),
              contentPadding: EdgeInsets.only(
                left: size.width * 0.02,
                right: size.width * 0.02,
              ),
              labelText: 'Search...',
              hintStyle: TextStyle(
                fontSize: size.width * 0.04,
                color: ThemeColors.grey,
                fontWeight: FontWeight.w500,
              ),
              labelStyle: TextStyle(
                fontSize: size.width * 0.04,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            autocorrect: false,
            onChanged: (value) {
              searchBloc.add(
                FoundSearchEvent(
                  (_controller.text.isEmpty) ? 'bitcoin' : _controller.text,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is FoundedSearchState) {
                if (state.articleResponse.error.isNotEmpty) {
                  return buildErrorWidget(
                    state.articleResponse.error,
                  );
                }
                return _buildSearchedNews(
                  data: state.articleResponse,
                  size: size,
                );
              } else if (state is NotFoundSearchState) {
                return buildErrorWidget('Nothing Loaded');
              } else {
                return buildLoadingWidget();
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSearchedNews(
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
                    padding: const EdgeInsets.only(
                      right: 10.0,
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

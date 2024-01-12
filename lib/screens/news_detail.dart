import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/style/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key, required this.article});
  final Article article;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.article.content);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launchUrl(
            Uri.parse(widget.article.url ?? ''),
          );
        },
        child: Container(
          color: ThemeColors.mainColor,
          height: size.height * 0.06,
          width: size.width,
          child: Center(
            child: Text(
              'Read More',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.04,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ThemeColors.mainColor,
        title: Text(
          widget.article.title ?? '',
          style: TextStyle(
            fontSize: size.width * 0.04,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.jpg',
              image: widget.article.img ?? '',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  widget.article.date?.substring(0, 10) ?? '',
                  style: const TextStyle(
                    color: ThemeColors.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  widget.article.title ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Html(
                  data: widget.article.content ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

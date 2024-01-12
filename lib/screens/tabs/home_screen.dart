import 'package:flutter/material.dart';
import 'package:news_app/widgets/headline_slider.dart';
import 'package:news_app/widgets/hot_news.dart';
import 'package:news_app/widgets/top_channels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        const HeadLineSliderWidget(),
        Padding(
          padding: EdgeInsets.all(
            size.width * 0.02,
          ),
          child: Text(
            'Top Channels',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.04),
          ),
        ),
        const TopChannels(),
        Padding(
          padding: EdgeInsets.all(
            size.width * 0.02,
          ),
          child: Text(
            'Hot News',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
            ),
          ),
        ),
        const HotNews(),
      ],
    );
  }
}

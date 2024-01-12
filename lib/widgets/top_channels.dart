import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/utils/constants.dart';

import '../blocs/get_sources_bloc/bloc/get_sources_bloc.dart';
import '../elements/error_element.dart';
import '../elements/loader_element.dart';

class TopChannels extends StatefulWidget {
  const TopChannels({Key? key}) : super(key: key);

  @override
  State<TopChannels> createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetSourcesBloc>(context, listen: false)
        .add(LoadGetSourcesEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetSourcesBloc, GetSourcesState>(
      builder: (context, state) {
        if (state is LoadedGetSourcesState) {
          if (state.sourceResponse.error.isNotEmpty) {
            return buildErrorWidget(
              state.sourceResponse.error,
            );
          }
          return _buildTopChannels(
            response: state.sourceResponse,
            size: size,
          );
        } else if (state is NotLoadedGetSourcesState) {
          return buildErrorWidget('Nothing Loaded');
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildTopChannels(
      {required SourceResponse response, required Size size}) {
    List<Source> sources = response.sourcesList;
    if (sources.isEmpty) {
      return SizedBox(
        width: size.width,
        child: Column(
          children: const [
            Text(
              'No Sources',
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(
          top: size.width * 0.01,
          bottom: size.width * 0.01,
          left: size.width * 0.01,
          right: size.width * 0.01,
        ),
        height: size.height * 0.2,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: response.sourcesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    kSourceDetailPage,
                    arguments: sources[index],
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: sources[index].id.toString(),
                      child: FittedBox(
                        child: CircleAvatar(
                          maxRadius: size.width * 0.08,
                          foregroundImage: AssetImage(
                            'assets/logos/${sources[index].id}.png',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      sources[index].name ?? '',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.0250,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      sources[index].category ?? '',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: size.width * 0.022,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

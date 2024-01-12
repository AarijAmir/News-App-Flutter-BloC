import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/get_sources_bloc/bloc/get_sources_bloc.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/model/source_response.dart';

import '../../elements/error_element.dart';
import '../../elements/loader_element.dart';
import '../../utils/constants.dart';

class SourcesScreen extends StatefulWidget {
  const SourcesScreen({super.key});

  @override
  State<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetSourcesBloc>(context).add(LoadGetSourcesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSourcesBloc, GetSourcesState>(
      builder: (context, state) {
        if (state is LoadedGetSourcesState) {
          if (state.sourceResponse.error.isNotEmpty) {
            return buildErrorWidget(
              state.sourceResponse.error,
            );
          }
          return _buildSources(state.sourceResponse);
        } else if (state is NotLoadedGetSourcesState) {
          return buildErrorWidget('Nothing Loaded');
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildSources(SourceResponse data) {
    Size size = MediaQuery.of(context).size;
    List<Source> sources = data.sourcesList;
    return GridView.builder(
      itemCount: sources.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.86),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.012,
              right: size.width * 0.012,
              top: size.width * 0.024),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                kSourceDetailPage,
                arguments: sources[index],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(size.width * 0.01),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      1.0,
                      1.0,
                    ),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: sources[index].id ?? '',
                    child: Container(
                      height: size.width * 0.16,
                      width: size.width * 0.16,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/logos/${sources[index].id}.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      right: size.width * 0.01,
                      top: size.width * 0.04,
                      bottom: size.width * 0.04,
                    ),
                    child: Text(
                      sources[index].name ?? '',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.030,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

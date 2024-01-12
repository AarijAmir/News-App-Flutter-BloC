import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/bottom_navigation_bar_bloc/bloc/bottom_navigation_bar_bloc.dart';
import 'package:news_app/screens/tabs/home_screen.dart';
import 'package:news_app/screens/tabs/search_screen.dart';
import 'package:news_app/screens/tabs/sources_screen.dart';
import 'package:news_app/style/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: ThemeColors.mainColor,
          title: const Text(
            'News App',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
          builder: (context, state) {
            if (state is SourcesBottomNavigationBarState) {
              return const SourcesScreen();
            } else if (state is SearchBottomNavigationBarState) {
              return const SearchScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
        builder: (context, state) {
          return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
            builder: (context, state) {
              if (state is SourcesBottomNavigationBarState) {
                return BottomNavigationBar(
                  backgroundColor: Colors.white,
                  iconSize: size.width * 0.05,
                  unselectedItemColor: ThemeColors.grey,
                  items: _bottomNavigationBarItemList(),
                  unselectedFontSize: size.width * 0.025,
                  selectedFontSize: size.width * 0.025,
                  type: BottomNavigationBarType.fixed,
                  fixedColor: ThemeColors.mainColor,
                  currentIndex: 1,
                  onTap: (value) =>
                      openScreenViaIndex(context: context, index: value),
                );
              } else if (state is SearchBottomNavigationBarState) {
                return BottomNavigationBar(
                    backgroundColor: Colors.white,
                    iconSize: size.width * 0.05,
                    unselectedItemColor: ThemeColors.grey,
                    items: _bottomNavigationBarItemList(),
                    unselectedFontSize: size.width * 0.025,
                    selectedFontSize: size.width * 0.025,
                    type: BottomNavigationBarType.fixed,
                    fixedColor: ThemeColors.mainColor,
                    onTap: (value) =>
                        openScreenViaIndex(context: context, index: value),
                    currentIndex: 2);
              } else {
                return BottomNavigationBar(
                  backgroundColor: Colors.white,
                  iconSize: size.width * 0.05,
                  unselectedItemColor: ThemeColors.grey,
                  items: _bottomNavigationBarItemList(),
                  unselectedFontSize: size.width * 0.025,
                  selectedFontSize: size.width * 0.025,
                  type: BottomNavigationBarType.fixed,
                  fixedColor: ThemeColors.mainColor,
                  onTap: (value) =>
                      openScreenViaIndex(context: context, index: value),
                  currentIndex: 0,
                );
              }
            },
          );
        },
      ),
    );
  }

  void openScreenViaIndex({required BuildContext context, required int index}) {
    BottomNavigationBarBloc bottomNavigationBarBloc =
        BlocProvider.of<BottomNavigationBarBloc>(context, listen: false);
    if (index == 0) {
      bottomNavigationBarBloc.add(HomeBottomNavigationBarEvent());
    } else if (index == 1) {
      bottomNavigationBarBloc.add(SourcesBottomNavigationBarEvent());
    } else if (index == 2) {
      bottomNavigationBarBloc.add(SearchBottomNavigationBarEvent());
    }
  }

  Widget _testScreen() {
    return Container(
      color: Colors.orange,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('Test Screen'),
        ],
      ),
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItemList() => [
        const BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            EvaIcons.homeOutline,
          ),
          activeIcon: Icon(
            EvaIcons.home,
          ),
        ),
        const BottomNavigationBarItem(
          label: 'Sources',
          icon: Icon(
            EvaIcons.gridOutline,
          ),
          activeIcon: Icon(
            EvaIcons.grid,
          ),
        ),
        const BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            EvaIcons.search,
          ),
          activeIcon: Icon(
            EvaIcons.searchOutline,
          ),
        ),
      ];
}

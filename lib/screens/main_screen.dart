import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newapp/bloc/bottom_navbar_bloc.dart';
import 'package:newapp/screens/tag/home_screen.dart';
import 'package:newapp/screens/tag/search_screen.dart';
import 'package:newapp/screens/tag/sources_screen.dart';
import 'package:newapp/style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottomNavBarBloc;
  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Style.Colors.mainColor,
              title: Text(
                "NewsApp",
                style: TextStyle(color: Colors.white),
              ),
            ),
            preferredSize: Size.fromHeight(50)),
        body: SafeArea(
            child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return HomeScreen();
              case NavBarItem.SOURCES:
                return SourceScreen();
              case NavBarItem.SEARCH:
                return SearchScreen();
            }
          },
        )),
        bottomNavigationBar: StreamBuilder(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100],
                        spreadRadius: 0,
                        blurRadius: 10)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        title: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("Home"),
                        ),
                        icon: Icon(EvaIcons.homeOutline),
                        activeIcon: Icon(EvaIcons.home)),
                    BottomNavigationBarItem(
                        title: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("Source"),
                        ),
                        icon: Icon(EvaIcons.gridOutline),
                        activeIcon: Icon(EvaIcons.grid)),
                    BottomNavigationBarItem(
                        title: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("Search"),
                        ),
                        icon: Icon(EvaIcons.searchOutline),
                        activeIcon: Icon(EvaIcons.search)),
                  ],
                  backgroundColor: Colors.white,
                  iconSize: 20,
                  unselectedItemColor: Style.Colors.grey,
                  unselectedFontSize: 9.5,
                  selectedFontSize: 9.5,
                  type: BottomNavigationBarType.fixed,
                  fixedColor: Style.Colors.mainColor,
                  currentIndex: snapshot.data.index,
                  onTap: _bottomNavBarBloc.pickItem,
                ),
              ),
            );
          },
        ));
  }

  Widget textScreen() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Text Screen")],
      ),
    );
  }
}

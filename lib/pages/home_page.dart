import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dream_wall/pages/about_page.dart';
import 'package:dream_wall/pages/screen/home_screen.dart';
import 'package:dream_wall/pages/screen/random_screen.dart';
import 'package:dream_wall/pages/screen/search_screen.dart';
import 'package:flutter/material.dart';

enum PageEnum { aboutPage }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex;

  final List<Widget> buildScreens = [
    HomeScreen(),
    SearchScreen(),
    RandomScreen()
  ];

  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.aboutPage:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutPage()));
        break;
      default:
    }
  }

  Widget _popUpMenu() => PopupMenuButton<PageEnum>(
        onSelected: _onSelect,
        icon: Icon(Icons.more_vert, color: Colors.black),
        offset: Offset(0, 100),
        itemBuilder: (context) => [
          PopupMenuItem(child: Row(
            children: [
              Icon(Icons.info_outline),
              Text("About"),
            ],
          ), value: PageEnum.aboutPage),
        ],
      );

  final List<BubbleBottomBarItem> items = [
    BubbleBottomBarItem(
        backgroundColor: Colors.amber[900],
        icon: Icon(
          Icons.home,
          color: Colors.blueGrey,
        ),
        activeIcon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text("Home",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    BubbleBottomBarItem(
        backgroundColor: Colors.amber[900],
        icon: Icon(
          Icons.search,
          color: Colors.blueGrey,
        ),
        activeIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        title: Text("Search",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    BubbleBottomBarItem(
      backgroundColor: Colors.amber[900],
      icon: Icon(
        Icons.dashboard,
        color: Colors.blueGrey,
      ),
      activeIcon: Icon(
        Icons.dashboard,
        color: Colors.black,
      ),
      title: Text(
        "Random",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Image.asset("assets/Dream Wall-logos_black.png", width: 225),
        actions: <Widget>[_popUpMenu()],
      ),
      body: buildScreens[currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Colors.amber[600],
        hasNotch: true,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        elevation: 8,
        items: items,
      ),
    );
  }
}

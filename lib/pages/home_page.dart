import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dream_wall/pages/screen/home_screen.dart';
import 'package:dream_wall/pages/screen/random_screen.dart';
import 'package:dream_wall/pages/screen/search_screen.dart';
import 'package:flutter/material.dart';

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

  final List<BubbleBottomBarItem> items = [
    BubbleBottomBarItem(
        backgroundColor: Colors.deepOrange,
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
        backgroundColor: Colors.deepOrange,
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
        backgroundColor: Colors.deepOrange,
        icon: Icon(
          Icons.dashboard,
          color: Colors.blueGrey,
        ),
        activeIcon: Icon(
          Icons.dashboard,
          color: Colors.black,
        ),
        title: Text("Random",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
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
        title:
            Image.asset("assets/Dream Wall-logos_black.png", width: 225),
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

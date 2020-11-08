import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/home_screen.dart';

class BottomBars extends StatefulWidget {
  @override
  _BottomBarsState createState() => _BottomBarsState();
}

class _BottomBarsState extends State<BottomBars> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: BouncingScrollPhysics(),
          controller: _pageController,
          // dragStartBehavior: DragStartBehavior.down,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.greenAccent,
        color: Colors.black,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: [
          TabItem(
            icon: Icon(Icons.home),
            title: 'Home',
          ),
          TabItem(
            icon: Icon(Icons.search),
            title: 'Search',
          ),
          TabItem(
            icon: Icon(Icons.list),
            title: 'List',
          ),
        ],
        initialActiveIndex: 0,
      ),
    );
  }
}

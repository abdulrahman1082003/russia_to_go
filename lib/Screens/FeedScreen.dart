import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:russia_to_go/Screens/HomeScreen.dart';
import 'package:russia_to_go/Screens/NotificationsScreen.dart';
import 'package:russia_to_go/Screens/ProfileScreen.dart';
import 'package:russia_to_go/Screens/SearchScreen.dart';
import 'package:russia_to_go/Screens/Store.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;

  const FeedScreen({Key key, this.currentUserId}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        ProfileScreen(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
        NotificationsScreen(
          currentUserId: widget.currentUserId,
        ),
        HomeScreen(
          currentUserId: widget.currentUserId,
        ),
        SearchScreen(
          currentUserId: widget.currentUserId,
        ),
        Store()
      ].elementAt(_selectedTab),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,color: Colors.blueAccent,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        index: _selectedTab,
        items: [
          Icon(Icons.person,color: Colors.white,),
          Icon(Icons.notifications,color: Colors.white,),
          Icon(Icons.home,color: Colors.white,),
          Icon(Icons.search,color: Colors.white,),
          Icon(Icons.local_grocery_store_rounded,color: Colors.white,)
        ],
      ),
    );
  }
}

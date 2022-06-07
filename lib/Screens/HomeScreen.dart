import 'package:flutter/material.dart';
import 'package:russia_to_go/Constants/Constants.dart';
import 'package:russia_to_go/Models/Tweet.dart';
import 'package:russia_to_go/Models/UserModel.dart';
import 'package:russia_to_go/Screens/CreateTweetScreen.dart';
import 'package:russia_to_go/Services/DatabaseServices.dart';
import 'package:russia_to_go/Widgets/TweetContainer.dart';
import 'package:firebase_core/firebase_core.dart';
class HomeScreen extends StatefulWidget {
  final String currentUserId;

  const HomeScreen({Key key, this.currentUserId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _followingTweets = [];
  bool _loading = false;

  buildTweets(Tweet tweet, UserModel author) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TweetContainer(
        tweet: tweet,
        author: author,
        currentUserId: widget.currentUserId,
      ),
    );
  }

  showFollowingTweets(String currentUserId) {
    List<Widget> followingTweetsList = [];
    for (Tweet tweet in _followingTweets) {
      followingTweetsList.add(FutureBuilder(
          future: usersRef.doc(tweet.authorId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              UserModel author = UserModel.fromDoc(snapshot.data);
              return buildTweets(tweet, author);
            } else {
              return SizedBox.shrink();
            }
          }));
    }
    return followingTweetsList;
  }

  setupFollowingTweets() async {
    setState(() {
      _loading = true;
    });
    List followingTweets =
        await DatabaseServices.getHomeTweets(widget.currentUserId);
    if (mounted) {
      setState(() {
        _followingTweets = followingTweets;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setupFollowingTweets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(elevation: 15,
          backgroundColor: Colors.white,
          child: Image.asset('assets/tweet.png'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateTweetScreen(
                          currentUserId: widget.currentUserId,
                        )));
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 77,
          centerTitle: true,
          leading: Container(
            height: 40,
            child: Image.asset('assets/logo.png'),
          ),
          title: Text(
            'Our Community',
            style: TextStyle(
              color: KTweeterColor,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => setupFollowingTweets(),
          child: ListView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              _loading ? LinearProgressIndicator() : SizedBox.shrink(),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 5),
                  Column(
                    children: _followingTweets.isEmpty && _loading == false
                        ? [
                            SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                'There is No New Posts',
                                style: TextStyle(
                                  fontSize: 20,color: Colors.blueAccent
                                ),
                              ),
                            )
                          ]
                        : showFollowingTweets(widget.currentUserId),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

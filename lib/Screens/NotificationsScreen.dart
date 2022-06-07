import 'package:flutter/material.dart';
import 'package:russia_to_go/Constants/Constants.dart';
import 'package:russia_to_go/Models/Activity.dart';
import 'package:russia_to_go/Models/UserModel.dart';
import 'package:russia_to_go/Services/DatabaseServices.dart';
import 'package:firebase_core/firebase_core.dart';
class NotificationsScreen extends StatefulWidget {
  final String currentUserId;

  const NotificationsScreen({Key key, this.currentUserId}) : super(key: key);
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Activity> _activities = [];

  setupActivities() async {
    List<Activity> activities =
        await DatabaseServices.getActivities(widget.currentUserId);
    if (mounted) {
      setState(() {
        _activities = activities;
      });
    }
  }

  buildActivity(Activity activity) {
    return FutureBuilder(
        future: usersRef.doc(activity.fromUserId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return SizedBox.shrink();
          } else {
            UserModel user = UserModel.fromDoc(snapshot.data);
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: user.profilePicture.isEmpty
                        ? AssetImage('assets/placeholder.png')
                        : NetworkImage(user.profilePicture),
                  ),
                  title: activity.follow == true
                      ? Text('${user.name} follows you')
                      : Text('${user.name} liked your tweet'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: KTweeterColor,
                    thickness: 1,
                  ),
                )
              ],
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
    setupActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
          centerTitle: true,
          elevation: 20,
          title: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => setupActivities(),
          child: ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = _activities[index];
                return buildActivity(activity);
              }),
        ));
  }
}

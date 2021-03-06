
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:russia_to_go/Screens/FeedScreen.dart';
import 'package:russia_to_go/Screens/WelcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget  {
Widget getScreenId(){
  return StreamBuilder(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder:(BuildContext context,snapshot){
   if(snapshot.hasData) {
     return FeedScreen();
   }else {
     return WelcomeScreen();
   }
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: WelcomeScreen(),
    );
  }
}

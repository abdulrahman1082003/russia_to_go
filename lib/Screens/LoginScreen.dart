import 'package:flutter/material.dart';
import 'package:russia_to_go/Screens/FeedScreen.dart';

import '../Services/auth_service.dart';
import '../Widgets/RoundedButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 55),
        child: Column(
          children: [ SizedBox(
            height: 60,
          ),
            Center(
                child: Text(
              "Log In",
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            )),
            SizedBox(
              height: 66,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'please Enter Your email',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            SizedBox(
              height: 60,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Please Enter Your password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            RoundedButton(
              btnText: 'LOG IN',
              onBtnPressed: () async {
                bool isValid = await AuthService.login(_email, _password);
                if (isValid) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => FeedScreen()));
                } else {
                  print('login problem');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

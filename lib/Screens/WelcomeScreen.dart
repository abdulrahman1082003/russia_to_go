import 'package:flutter/material.dart';
import 'package:russia_to_go/Screens/LoginScreen.dart';
import 'RegistrationScreen.dart';
import '../Widgets/RoundedButton.dart';
import 'package:firebase_core/firebase_core.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    height: 200,
                    width: 200,
                  ),

                ],
              ),
              Column(
                children: [
                  Flexible(
                    child: RoundedButton(
                        btnText: 'LOG IN',
                        onBtnPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                      btnText: 'Create account',
                      onBtnPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

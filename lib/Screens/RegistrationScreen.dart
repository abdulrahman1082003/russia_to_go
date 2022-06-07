import 'package:flutter/material.dart';
import 'package:russia_to_go/Constants/Constants.dart';
import 'package:russia_to_go/Services/auth_service.dart';
import 'package:russia_to_go/Widgets/RoundedButton.dart';
import 'package:firebase_core/firebase_core.dart';
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
    String _email;
    String _password;
    String _name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KTweeterColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Registration Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            RoundedButton(
              btnText: 'Create new account',
              onBtnPressed: () async {
                bool isValid =
                    await AuthService.signUp(_name, _email, _password);
                if (isValid) {
                  Navigator.pop(context);
                } else {
                  print('something is wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

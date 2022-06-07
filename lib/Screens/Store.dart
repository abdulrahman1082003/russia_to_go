import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Store extends StatelessWidget {
  const Store({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(elevation: 55, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
          backgroundColor: Colors.blueAccent,
          title: Center(
            child: Text('Our Store',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        body: Column(mainAxisAlignment:MainAxisAlignment.center ,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.store_outlined,
                size: 100,color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: Text('This page is under development',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 190,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/itgLogo.jpg'), fit: BoxFit.fill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

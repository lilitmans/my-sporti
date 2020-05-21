import 'package:flutter/material.dart';
import 'club_selection_screen.dart';
import '../common/theme.dart';
import '../common/app_bar.dart';
import 'dart:async';
import '../repositories/repositories.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String title = 'My Sporti';

  @override
  void initState() {
    super.initState();
    new Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ClubSelectionScreen()),
          (Route<dynamic> route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(title: appBar(context, '')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo.png'),
              SizedBox(height: 25),
              Text(
                'mySporti',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Reservierung und Forderung leicht gemacht!'),
            ],
          ),
        ),
      ),
    );
  }
}

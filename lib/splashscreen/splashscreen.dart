import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsappyhigh/screens/news_homescreen.dart';
import 'package:newsappyhigh/viewmodels/news_article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'delayed_animation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();

    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 8), () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (_) => NewsListViewModel(),
                      )
                    ],
                    child: NewsHomeScreen(),
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.black;
    _scale = 1 - _controller.value;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            DelayedAnimation(
              child: Container(
                  height: 300,
                  child: Image.network(
                      "https://static.dribbble.com/users/33046/screenshots/3011204/news-2.png")),
            ),
            SizedBox(
              height: 10,
            ),
            DelayedAnimation(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: new AlwaysStoppedAnimation(-90 / 360),
                    child: Text(
                      "Latest News",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: color),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 280,
                    decoration: new BoxDecoration(
                        color: Hexcolor('#ECECF3'),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Intern",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Hexcolor("#B2B2C9")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "News app made with news api "
                              "for Appy high internship role"
                              " By: Divyam Joshi",
                              maxLines: 4,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              delay: delayedAmount + 1000,
            ),
            SizedBox(
              height: 20.0,
            ),
            DelayedAnimation(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "News that matter",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: color),
                    ),
                    Text(
                      "Hope you like it"
                      "News that tell the "
                      "truth",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Hexcolor("#B2B2C9")),
                    ),
                  ],
                ),
              ),
              delay: delayedAmount + 2000,
            ),
            SizedBox(
              height: 2.0,
            ),
            DelayedAnimation(
              child: AvatarGlow(
                endRadius: 70,
                duration: Duration(seconds: 2),
                glowColor: Colors.black12,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 2),
                startDelay: Duration(seconds: 1),
                child: Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Hexcolor("#0D0D0D"),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Text("Read",
                      style: TextStyle(
                          height: 1.2,
                          wordSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.white)),
                ),
              ),
              delay: delayedAmount + 3000,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ));
  }
}

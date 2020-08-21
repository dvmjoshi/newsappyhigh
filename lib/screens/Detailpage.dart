import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:newsappyhigh/screens/webviewpage.dart';
import 'package:newsappyhigh/utils/ads.dart';
import 'package:newsappyhigh/viewmodels/news_viewmodel.dart';

class DetailPage extends StatefulWidget {
  final NewsViewModel newsdata;

  DetailPage({Key key, @required this.newsdata}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  Animation opacityContainer;
  Animation translateDownContainer;
  Animation translateUpText;
  Animation opacityText;
  AnimationController animationController;

  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..addListener(() {
        setState(() {});
      });
    translateDownContainer =
        Tween(begin: Offset(0.0, 20), end: Offset(0.0, 0.0)).animate(
            CurvedAnimation(curve: Curves.easeIn, parent: animationController));
    opacityContainer = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(0.4, 0.7, curve: Curves.easeIn),
        parent: animationController));
    translateUpText = Tween(begin: Offset(0.0, -20), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      curve: Interval(0.7, 1.0, curve: Curves.easeIn),
      parent: animationController,
    ));
    opacityText = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        curve: Interval(0.8, 0.9, curve: Curves.easeIn),
        parent: animationController));
    animationController.forward();
    Ads.hideBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Hero(
              tag: widget.newsdata.imageUrl ?? "",
              child: Image(
                image: NetworkImage(widget.newsdata.imageUrl ?? ""),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2 - 40,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.2 - 100,
            left: 20,
            child: Transform.translate(
              offset: translateDownContainer.value,
              child: Opacity(
                opacity: opacityContainer.value,
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 3,
                        height: 50,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          Text(
//                            widget.name.toUpperCase(),
//                            style: TextStyle(fontSize: 16, letterSpacing: 2),
//                          ),
//                          SizedBox(
//                            height: 20,
//                          ),
                          Container(
                            width: 300,
                            child: Text(
                              widget.newsdata.author ?? "",
                              style:
                                  TextStyle(fontFamily: "Butler", fontSize: 30),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Transform.translate(
                            offset: translateUpText.value,
                            child: Opacity(
                              opacity: opacityText.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      widget.newsdata.title ??
                                          "no content found",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 280,
                                    child: Text(
                                      widget.newsdata.description ??
                                          "no content found",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 280,
                                    child: Text(
                                      widget.newsdata.content ??
                                          "no content found",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          Row(
                            children: <Widget>[
                              Container(
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebViewNews(
                                                  postUrl: widget.newsdata.url,
                                                )));
                                  },
                                  color: Color(0xFF2B65F9),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 12.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.play_circle_outline,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Read more',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 40,
                                height: 2,
                                color: Colors.black,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color(0xFF7B51D3),
        ),
        child: Center(
          child: Row(
            children: [
              Icon(Icons.play_circle_outline),
              Text(
                'Watch',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
}

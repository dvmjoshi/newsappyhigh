import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:newsappyhigh/screens/newsfeed.dart';
import 'package:newsappyhigh/services/Location%20service.dart';
import 'package:newsappyhigh/utils/Admanager.dart';
import 'package:newsappyhigh/utils/ads.dart';
import 'package:newsappyhigh/utils/news_key.dart';
import 'package:newsappyhigh/viewmodels/news_article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsHomeScreen extends StatefulWidget {
  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  bool a;
  bool ads = false;
  Widget adshow;

  //Ads show;
  final Firestore banner = Firestore.instance;
  final Firestore startingpage = Firestore.instance;
  bool _click = false;
  List<Widget> bookmark = [];

  @override
  void initState() {
    super.initState();
    Provider.of<NewsListViewModel>(context, listen: false).topHeadlines();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _newsList(NewsListViewModel vs) {
    switch (vs.loadingStatus) {
      case LoadingStatus.searching:
        return Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.completed:
        return Container(
          height: MediaQuery.of(context).size.height,
          child: NewsFeed(
            feed: vs.news,
          ),
        );
      case LoadingStatus.empty:
      default:
        return Center(
          child: Text("No results found"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<NewsListViewModel>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: StreamBuilder<Object>(
              stream: startingpage.collection('Appyhighads').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        expandedHeight: 350.0,
                        floating: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(

                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 40, left: 0),
                                  child: Text(
                                    "NewsLife",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: "Butler",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 30, left: 0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.menu,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 250,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                launch(
                                                                    "https://github.com/dvmjoshi");
                                                              },
                                                              child: Container(
                                                                height: 60.0,
                                                                width: 125.0,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0)),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Github A/c',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      new Container(
                                                          child: new Padding(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                      32.0),
                                                              child: new Text(
                                                                  'made'
                                                                  'for Appy High '
                                                                  '\ncontact:graspapp7@gmail.com ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          14.0)))),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        color: Color(0xFFBBCCCC),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            background: Stack(
                              children: <Widget>[
                                Image.network(
                                    "https://static.dribbble.com/users/1097364/screenshots/5511724/features-shot006.gif")
                              ],
                            )),
                      ),
                    ];
                  },
                  body: Stack(
                    children: [
                      Container(
                        child: ads != snapshot.data.documents[0]['bool']
                            ? Ads.showBannerAd()
                            : Ads.hideBannerAd(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: 250,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Filter ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Category',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: '&',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: 'Location',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              color: Colors.black,
                              child: PopupMenuButton<String>(
                                onSelected: (value) {
                                  _selectCategory(data, value);
                                },
                                icon: Icon(
                                  Icons.sort,
                                  color: Colors.white,
                                  size: 34,
                                ),
                                itemBuilder: (_) {
                                  return NewsKey.Category.keys
                                      .map((v) => PopupMenuItem(
                                            value: v,
                                            child: Text(v),
                                          ))
                                      .toList();
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              color: Colors.black,
                              child: PopupMenuButton<String>(
                                onSelected: (value) {
                                  _selectCountry(data, value);
                                },
                                icon: Icon(Icons.view_headline,
                                    color: Colors.white, size: 34),
                                itemBuilder: (_) {
                                  return NewsKey.Countries.keys
                                      .map((v) => PopupMenuItem(
                                            value: v,
                                            child: Text(v),
                                          ))
                                      .toList();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: _newsList(data)),
                    ],
                  ),
                );
              })),
    );
  }

  void _selectCountry(NewsListViewModel news, String country) {
    news.topHeadlinesByCountry(NewsKey.Countries[country]);
  }

  void _selectCategory(NewsListViewModel news, String category) {
    news.topHeadlinesByCategory(NewsKey.Category[category]);
  }
}

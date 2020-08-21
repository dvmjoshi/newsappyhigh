import 'package:flutter/material.dart';
import 'package:newsappyhigh/screens/Detailpage.dart';
import 'package:newsappyhigh/viewmodels/news_viewmodel.dart';

class NewsFeed extends StatelessWidget {
  final List<NewsViewModel> feed;

  NewsFeed({this.feed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.feed.length,
        itemBuilder: (context, index) {
          final newsdata = this.feed[index];

          return Padding(
            key: ValueKey(newsdata.author ?? ""),
            padding: EdgeInsets.all(8),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      newsdata: newsdata,
                                    )),
                          );
                        },
                        child: Hero(
                          tag: newsdata.imageUrl ?? "",
                          child: Container(
                            height: 210,
                            width: 350,
                            margin: EdgeInsets.only(left: 0, right: 0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(newsdata.imageUrl ?? ""),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 7,
                                  spreadRadius: 3,
                                  color: Colors.blue[900].withOpacity(0.1),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          newsdata.author ?? "",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                        ),
                        label: Text(""),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      newsdata.title ?? "",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      newsdata.publishedAt ?? "",
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              ),
            ),
          );
        });
  }
}

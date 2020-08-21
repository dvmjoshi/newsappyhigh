import 'package:flutter/material.dart';
import 'package:newsappyhigh/model/NewsModel.dart';
import 'package:newsappyhigh/services/webservices.dart';

import 'news_viewmodel.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class NewsListViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.searching;
  List<NewsViewModel> news = List<NewsViewModel>();

  void topHeadlinesByCountry(String country) async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<NewsModel> newsArticles =
        await WebServices().fetchHeadlinesByCountry(country);

    this.news = newsArticles.map((news) => NewsViewModel(news: news)).toList();

    if (this.news.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }

  void topHeadlinesByCategory(String category) async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<NewsModel> newsArticles =
        await WebServices().fetchHeadlinesByCategory(category);

    this.news = newsArticles.map((news) => NewsViewModel(news: news)).toList();

    if (this.news.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }

  void topHeadlinesByLocation(String location) async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<NewsModel> newsArticles =
        await WebServices().fetchHeadlinesByLocation(location);

    this.news = newsArticles.map((news) => NewsViewModel(news: news)).toList();

    if (this.news.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }

  void topHeadlines() async {
    List<NewsModel> newsArticles = await WebServices().fetchTopHeadlines();
    notifyListeners();

    this.news = newsArticles.map((news) => NewsViewModel(news: news)).toList();

    if (this.news.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }
}

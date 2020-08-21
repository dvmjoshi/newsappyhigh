import 'package:dio/dio.dart';

import 'package:newsappyhigh/model/NewsModel.dart';
import 'package:newsappyhigh/utils/news_key.dart';

class WebServices {
  var dio = new Dio();

  Future<List<NewsModel>> fetchHeadlinesByCountry(String country) async {
    final response = await dio.get(NewsKey.headlinesFor(country));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsModel.fromJson(article)).toList();
    } else {
      throw Exception("Failled to get top news");
    }
  }

  Future<List<NewsModel>> fetchHeadlinesByCategory(String category) async {
    final response = await dio.get(NewsKey.categoryFor(category));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsModel.fromJson(article)).toList();
    } else {
      throw Exception("Failled to get top news");
    }
  }

  Future<List<NewsModel>> fetchHeadlinesByLocation(String location) async {
    String url = NewsKey.locationFor(location);
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsModel.fromJson(article)).toList();
    } else {
      throw Exception("Failled to get top news");
    }
  }

  Future<List<NewsModel>> fetchTopHeadlines() async {
    String url = NewsKey.TOP_HEADLINES_URL;

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsModel.fromJson(article)).toList();
    } else {
      throw Exception("Failled to get top news");
    }
  }
}

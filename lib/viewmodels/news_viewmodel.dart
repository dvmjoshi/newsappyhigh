import 'package:intl/intl.dart';
import 'package:newsappyhigh/model/NewsModel.dart';

class NewsViewModel {
  NewsModel _news;

  NewsViewModel({NewsModel news}) : _news = news;

  String get title {
    return _news.title;
  }

  String get description {
    return _news.description;
  }

  String get imageUrl {
    return _news.urlToImage;
  }

  String get url {
    return _news.url;
  }

  String get author {
    return _news.author;
  }

  String get content {
    return _news.content;
  }

  String get publishedAt {
    final dateTime =
        DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(_news.publishedAt, true);
    return DateFormat.yMMMMEEEEd('en-us').format(dateTime).toString();
  }
}

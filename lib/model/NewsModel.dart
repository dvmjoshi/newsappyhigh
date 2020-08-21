class NewsModel {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String author;
  final String content;
  final String publishedAt;

  NewsModel(
      {this.title,
      this.description,
      this.urlToImage,
      this.url,
      this.author,
      this.content,
      this.publishedAt});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        title: json["title"],
        description: json["description"],
        urlToImage: json["urlToImage"],
        url: json["url"],
        author: json["author"],
        content: json["content"],
        publishedAt: json["publishedAt"]);
  }
}

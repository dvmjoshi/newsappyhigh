class NewsKey {
  static const String API_KEY = 'fb9c93887dd84a74aee92261b48c9ff1';
  static const String TOP_HEADLINES_URL =
      'https://newsapi.org/v2/top-headlines?country=in&apiKey=$API_KEY';
  static String locationFor(String location) {
    return 'https://newsapi.org/v2/top-headlines?country=$location&apiKey=$API_KEY';
  }

  static String headlinesFor(String country) {
    return 'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$API_KEY';
  }

  static String categoryFor(String category) {
    return 'http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$API_KEY';
  }

  static const Map<String, String> Countries = {
    "India": "in",
    "Us": "us",
    "Russia": "ru",
    "Canada": "ca",
    "France": "fr"
  };
  static const Map<String, String> Category = {
    "Science": "science",
    "Technology": "technology",
    "Business": "business",
    "Entertainment": "entertainment",
  };
}

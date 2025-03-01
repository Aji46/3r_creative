class GetNews {
  bool success;
  GetNewsNews news;
  String message;

  GetNews({
    required this.success,
    required this.news,
    required this.message,
  });

  factory GetNews.fromJson(Map<String, dynamic> json) {
    return GetNews(
      success: json['success'],
      news: GetNewsNews.fromJson(json['news']),
      message: json['message'],
    );
  }
}

class GetNewsNews {
  String id;
  List<NewsElement> news;
  String createdBy;
  int v;

  GetNewsNews({
    required this.id,
    required this.news,
    required this.createdBy,
    required this.v,
  });

  factory GetNewsNews.fromJson(Map<String, dynamic> json) {
    return GetNewsNews(
      id: json['_id'],
      news: (json['news'] as List).map((e) => NewsElement.fromJson(e)).toList(),
      createdBy: json['createdBy'],
      v: json['__v'],
    );
  }
}

class NewsElement {
  String title;
  String description;
  String id;
  DateTime createdAt;

  NewsElement({
    required this.title,
    required this.description,
    required this.id,
    required this.createdAt,
  });

  factory NewsElement.fromJson(Map<String, dynamic> json) {
    return NewsElement(
      title: json['title'],
      description: json['description'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
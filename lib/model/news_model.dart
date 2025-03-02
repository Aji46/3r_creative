class GetNews {
  final bool success;
  final GetNewsNews news;
  final String message;

  GetNews({
    required this.success,
    required this.news,
    required this.message,
  });

  factory GetNews.fromJson(Map<String, dynamic> json) {
    return GetNews(
      success: json['success'] ?? false,
      news: GetNewsNews.fromJson(json['news'] ?? {}),
      message: json['message'] ?? '',
    );
  }
}

class GetNewsNews {
  final String id;
  final List<NewsElement> news;
  final String createdBy;
  final int v;

  GetNewsNews({
    required this.id,
    required this.news,
    required this.createdBy,
    required this.v,
  });

  factory GetNewsNews.fromJson(Map<String, dynamic> json) {
    return GetNewsNews(
      id: json['_id'] ?? '',
      news: (json['news'] as List? ?? []).map((e) => NewsElement.fromJson(e)).toList(),
      createdBy: json['createdBy'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}

class NewsElement {
  final String title;
  final String description;
  final String id;
  final DateTime createdAt;

  NewsElement({
    required this.title,
    required this.description,
    required this.id,
    required this.createdAt,
  });

  factory NewsElement.fromJson(Map<String, dynamic> json) {
    return NewsElement(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      id: json['_id'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
} 
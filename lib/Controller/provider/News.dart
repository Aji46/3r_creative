import 'package:flutter/material.dart';
import 'package:r_creative/model/Get_news_Model.dart';

import '../services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();
  GetNews? _newsData;
  bool _isLoading = false;

  GetNews? get newsData => _newsData;
  bool get isLoading => _isLoading;

  Future<void> loadNews() async {
    _isLoading = true;
    notifyListeners();

    _newsData = await _newsService.fetchNews();
    
    _isLoading = false;
    notifyListeners();
  }
}

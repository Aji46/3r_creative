
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:r_creative/model/Get_news_Model.dart';


class NewsService {

    static String API_BASE_URL = dotenv.env['API_BASE_URL'] ?? "";
  static String ADMIN_ID = dotenv.env['ADMIN_ID'] ?? "";
  static String HEADER_KEY = dotenv.env['HEADER_KEY'] ?? "";
  static String HEADER_VALUE = dotenv.env['HEADER_VALUE'] ?? "";

  Future<GetNews?> fetchNews() async {
    try {
      final response = await http.get(    Uri.parse("${API_BASE_URL}get-news/$ADMIN_ID"),
        headers: {
          "Content-Type": "application/json",
          HEADER_KEY: HEADER_VALUE,
        },);
             print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return GetNews(
          success: data['success'],
          message: data['message'],
          news: GetNewsNews(
            id: data['news']['_id'],
            createdBy: data['news']['createdBy'],
            v: data['news']['__v'],
            news: (data['news']['news'] as List)
                .map((item) => NewsElement(
                      title: item['title'],
                      description: item['description'],
                      id: item['_id'],
                      createdAt: DateTime.parse(item['createdAt']),
                    ))
                .toList(),
          ),
        );
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      debugPrint("Error fetching news: $e");
      return null;
    }
  }
}

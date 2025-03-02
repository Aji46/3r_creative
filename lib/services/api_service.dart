import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/server_model.dart';
import '../model/commodity_model.dart';
import '../model/news_model.dart';

class ApiService {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? "";
  static String get adminId => dotenv.env['ADMIN_ID'] ?? "";
  static String get headerKey => dotenv.env['HEADER_KEY'] ?? "";
  static String get headerValue => dotenv.env['HEADER_VALUE'] ?? "";

  static Map<String, String> get _headers => {
    "Content-Type": "application/json",
    headerKey: headerValue,
  };

  static Future<GetServer?> fetchServer() async {
    try {
      final response = await http.get(
        Uri.parse("$apiBaseUrl/get-server"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return GetServer.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print('Error fetching server info: $e');
      return null;
    }
  }

  static Future<GetCommodities?> fetchCommodities() async {
    try {
      final response = await http.get(
        Uri.parse("$apiBaseUrl/get-commodities/$adminId"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return GetCommodities.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print('Error fetching commodities: $e');
      return null;
    }
  }

  static Future<GetNews?> fetchNews() async {
    try {
      final response = await http.get(
        Uri.parse("$apiBaseUrl/get-news/$adminId"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return GetNews.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print('Error fetching news: $e');
      return null;
    }
  }
} 
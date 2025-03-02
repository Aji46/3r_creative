import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:r_creative/model/Get_commides.dart';
import 'package:r_creative/model/Get_server.dart';

class ApiService {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? "";
  static String get adminId => dotenv.env['ADMIN_ID'] ?? "";
  static String get headerKey => dotenv.env['HEADER_KEY'] ?? "";
  static String get headerValue => dotenv.env['HEADER_VALUE'] ?? "";

  // Method to fetch commodities
  Future<GetCommodities> getCommodities() async {
    final response = await http.get(
      Uri.parse('$apiBaseUrl/get-commodities/$adminId'),
      headers: {headerKey: headerValue},
    );

    if (response.statusCode == 200) {
      return GetCommodities.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load commodities');
    }
  }

  // Method to fetch server details
  Future<GetServer> getServer() async {
    final response = await http.get(
      Uri.parse('$apiBaseUrl/get-server'),
      headers: {headerKey: headerValue},
    );

    if (response.statusCode == 200) {
      return GetServer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load server details');
    }
  }
}
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/Get_server.dart';

class ServerService {
  

    static String API_BASE_URL = dotenv.env['API_BASE_URL'] ?? "";
  static String ADMIN_ID = dotenv.env['ADMIN_ID'] ?? "";
  static String HEADER_KEY = dotenv.env['HEADER_KEY'] ?? "";
  static String HEADER_VALUE = dotenv.env['HEADER_VALUE'] ?? "";

  
  Future<GetServer> getServerInfo() async {
    try {
      final response = await http.get( Uri.parse('${API_BASE_URL}get-server'),
      headers: {
        HEADER_KEY: HEADER_VALUE, 
      },
    );
    print(response.statusCode);
      
      if (response.statusCode == 200) {
        
        final Map<String, dynamic> data = json.decode(response.body);
        print(data['success']);
        print(data['info']['serverUrl']);
        print( data['info']['serverName']);
        print(  data['message']);
        return GetServer(
          success: data['success'],
          info: Info(
            serverUrl: data['info']['serverUrl'],
            serverName: data['info']['serverName'],
          ),
          message: data['message'],
        );

        
      } else {

        throw Exception('Failed to load server info');
      }
    } catch (e) {
      throw Exception('Error getting server info: $e');
    }
  }
} 
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:r_creative/model/profile.dart';


class ProfileService  {

    static String API_BASE_URL = dotenv.env['API_BASE_URL'] ?? "";
  static String ADMIN_ID = dotenv.env['ADMIN_ID'] ?? "";
  static String HEADER_KEY = dotenv.env['HEADER_KEY'] ?? "";
  static String HEADER_VALUE = dotenv.env['HEADER_VALUE'] ?? "";
  Future<GetProfile> fetchProfile() async {
    final  response = await http.get(Uri.parse("${API_BASE_URL}get-profile/$ADMIN_ID"),
       headers: {
          "Content-Type": "application/json",
          HEADER_KEY: HEADER_VALUE,
        },
    );

print('Response Status Code: ${response.statusCode}');
print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GetProfile(
        message: data['message'] ?? 'No message',
        success: data['success'] ?? false,
        info: Info(
            id: data['info']['_id'] ?? '',
          userName: data['info']['userName'] ?? '',
          companyName: data['info']['companyName'] ?? '',
          address: data['info']['address'] ?? '',
          email: data['info']['email'] ?? '',
          contact: data['info']['contact'] ?? 0,
          whatsapp: data['info']['whatsapp'] ?? 0,
        ),
      );
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
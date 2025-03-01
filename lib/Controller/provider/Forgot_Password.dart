import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:r_creative/model/Login_model.dart';
import 'package:r_creative/view/auth/login_screen.dart';


class ForgotProvider extends ChangeNotifier {
  static const String API_BASE_URL = "https://api.task.aurify.ae/user/";
  static const String ADMIN_ID = "66e994239654078fd531dc2a";
  static const String HEADER_KEY = "X-Secret-Key";
  static const String HEADER_VALUE = "IfiuH/Ox6QKC3jP6ES6Y+aGYuGJEAOkbJb";

  String? _deviceToken;

  void setDeviceToken(String token) {
    _deviceToken = token;
    notifyListeners();
  }

  bool _isLoading = false;
  String? _errorMessage;
  LoginUser? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginUser? get user => _user;

  final Dio _dio = Dio();
  final String baseUrl = "https://api.task.aurify.ae";
  final String secretKey = "IfiuH/Ox6QKC3jP6ES6Y+aGYuGJEAOkbJb";

  Future<bool> resetPassword({
    required String contact,
    required String newPassword,
    required String adminId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.put(
        '$baseUrl/user/forgot-password/$adminId',
        data: {
          'contact': contact,
          'password': newPassword,
        },
        options: Options(
          headers: {
            'X-Secret-Key': secretKey,
          },
        ),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      if (e is DioException) {
        _errorMessage = e.response?.data['message'] ?? 'Password reset failed';
      } else {
        _errorMessage = 'An unexpected error occurred';
      }
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> forgetpass(BuildContext context, String password, {required String contact}) async {
    if (_deviceToken == null) {
      _errorMessage = "Device token not available";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse("${API_BASE_URL}forgot-password/$ADMIN_ID"),
        body: jsonEncode({
          "contact": int.parse(contact),
          "password": password,
          "token": _deviceToken
        }),
        headers: {
          "Content-Type": "application/json",
          HEADER_KEY: HEADER_VALUE,
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
        print("Login success ++++++++++++++++++++++++++");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );

      } else {
        Map<String, dynamic> errorData = json.decode(response.body);
        _errorMessage = errorData['message'] ?? "Invalid credentials";
      }
    } catch (e) {
      _errorMessage = "Something went wrong! ${e.toString()}";
      print("Login error: ${e.toString()}");
    }

    _isLoading = false;
    notifyListeners();
  }
}

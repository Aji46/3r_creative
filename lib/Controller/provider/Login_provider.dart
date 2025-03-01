import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:r_creative/model/Login_model.dart';
import 'package:r_creative/view/home/Bottom_Nav_bar.dart';


class LoginProvider extends ChangeNotifier {
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

  Future<void> login(BuildContext context, String contact, String password) async {
    if (_deviceToken == null) {
      _errorMessage = "Device token not available";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("${API_BASE_URL}login/$ADMIN_ID"),
        body: jsonEncode({
          "contact": int.parse(contact)?? 0,
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
        _user = loginUserFromJson(response.body);
        print("Login success ++++++++++++++++++++++++++");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
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

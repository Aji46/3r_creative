import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:r_creative/model/Login_model.dart';
import 'package:r_creative/view/auth/login_screen.dart';
import 'package:r_creative/view/home/Bottom_Nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  static String API_BASE_URL = dotenv.env['API_BASE_URL'] ?? "";
  static String ADMIN_ID = dotenv.env['ADMIN_ID'] ?? "";
  static String HEADER_KEY = dotenv.env['HEADER_KEY'] ?? "";
  static String HEADER_VALUE = dotenv.env['HEADER_VALUE'] ?? "";

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
      _showSnackbar(context, "Device token not available", Colors.red);
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("${API_BASE_URL}login/$ADMIN_ID"),
        body: jsonEncode({
          "contact": int.parse(contact),
          "password": password.toString(),
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

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', response.body);
        await prefs.setString('token', _user!.token);
        await prefs.setString('admin_id', _user!.info.adminId);
        await prefs.setBool('is_logged_in', true);

        _showSnackbar(context, "Login successful!", Colors.green);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      } else {
        Map<String, dynamic> errorData = json.decode(response.body);
        _errorMessage = errorData['message'] ?? "Invalid credentials";
        _showSnackbar(context, _errorMessage!, Colors.red);
      }
    } catch (e) {
      _errorMessage = "Something went wrong! ${e.toString()}";
      _showSnackbar(context, _errorMessage!, Colors.red);
      print("Login error: ${e.toString()}");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.clear();
      
      _user = null;
      _deviceToken = null;
      _errorMessage = null;
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      print("Logout error: ${e.toString()}");
    }
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: color,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

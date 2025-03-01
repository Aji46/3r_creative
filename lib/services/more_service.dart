import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MoreService {
  final Dio _dio = Dio();
  final String baseUrl = "https://api.task.aurify.ae";
  final String secretKey = "IfiuH/Ox6QKC3jP6ES6Y+aGYuGJEAOkbJb";

  MoreService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['X-Secret-Key'] = secretKey;
        return handler.next(options);
      },
    ));
  }

  // Get user profile
  Future<Map<String, dynamic>> getProfile(String adminId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/user/get-profile/$adminId',
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Get user orders
  Future<Map<String, dynamic>> getOrders(String adminId, String userId, {
    String orderStatus = 'Success',
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/user/fetch-order/$adminId/$userId',
        queryParameters: {
          'orderStatus': orderStatus,
          'page': page,
          'limit': limit,
        },
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Get user wishlist
  Future<Map<String, dynamic>> getWishlist(String userId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/get-wishlist/$userId',
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Change password
  Future<Map<String, dynamic>> changePassword(String adminId, String contact, String newPassword) async {
    try {
      final response = await _dio.put(
        '$baseUrl/user/forgot-password/$adminId',
        data: {
          'contact': contact,
          'password': newPassword,
        },
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Get news
  Future<Map<String, dynamic>> getNews(String adminId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/user/get-news/$adminId',
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Get commodities
  Future<Map<String, dynamic>> getCommodities(String adminId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/user/get-commodities/$adminId',
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Get banks
  Future<Map<String, dynamic>> getBanks(String adminId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/user/get-banks/$adminId',
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Handle errors
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        throw Exception(error.response?.data['message'] ?? 'An error occurred');
      }
      throw Exception('Network error occurred');
    }
    throw Exception('An unexpected error occurred');
  }
} 
import 'package:flutter/material.dart';
import 'package:r_creative/services/more_service.dart';

class MoreProvider extends ChangeNotifier {
  final MoreService _moreService = MoreService();
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _news;
  Map<String, dynamic>? _commodities;
  Map<String, dynamic>? _banks;
  Map<String, dynamic>? _orders;
  Map<String, dynamic>? _wishlist;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get news => _news;
  Map<String, dynamic>? get commodities => _commodities;
  Map<String, dynamic>? get banks => _banks;
  Map<String, dynamic>? get orders => _orders;
  Map<String, dynamic>? get wishlist => _wishlist;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> fetchNews(String adminId) async {
    try {
      _setLoading(true);
      _setError(null);
      _news = await _moreService.getNews(adminId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchCommodities(String adminId) async {
    try {
      _setLoading(true);
      _setError(null);
      _commodities = await _moreService.getCommodities(adminId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchBanks(String adminId) async {
    try {
      _setLoading(true);
      _setError(null);
      _banks = await _moreService.getBanks(adminId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchOrders(String adminId, String userId, {
    String orderStatus = 'Success',
    int page = 1,
    int limit = 10,
  }) async {
    try {
      _setLoading(true);
      _setError(null);
      _orders = await _moreService.getOrders(
        adminId,
        userId,
        orderStatus: orderStatus,
        page: page,
        limit: limit,
      );
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchWishlist(String userId) async {
    try {
      _setLoading(true);
      _setError(null);
      _wishlist = await _moreService.getWishlist(userId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> changePassword(String adminId, String contact, String newPassword) async {
    try {
      _setLoading(true);
      _setError(null);
      await _moreService.changePassword(adminId, contact, newPassword);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 
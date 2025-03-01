import 'package:flutter/material.dart';
import 'package:r_creative/Controller/Services/get_spot_service.dart';
import 'package:r_creative/model/Get_spot_Model.dart';

class SpotratesProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  GetSpotrates? spotrates;
  bool isLoading = true;

  Future<void> getSpotrates() async {
    try {
      isLoading = true;
      notifyListeners();
      spotrates = await _apiService.fetchSpotrates();
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

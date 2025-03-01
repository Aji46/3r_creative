import 'package:flutter/material.dart';
import 'package:r_creative/Controller/Services/Profile_api_serivice.dart';
import 'package:r_creative/model/profile.dart';


class ProfileProvider with ChangeNotifier {
  GetProfile? _profile;
  bool _isLoading = false;

  GetProfile? get profile => _profile;
  bool get isLoading => _isLoading;

  final ProfileService _profileService = ProfileService();

  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();

    _profile = await _profileService.fetchProfile();

    _isLoading = false;
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

enum Status {
  initial,
  loading,
  success,
  error,
}

class BaseProvider extends ChangeNotifier {
  Status _status = Status.initial;
  String _errorMessage = '';

  Status get status => _status;
  String get errorMessage => _errorMessage;
  bool get isLoading => _status == Status.loading;

  void setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  void setError(String message) {
    _status = Status.error;
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> handleAsync<T>(Future<T> Function() asyncFunction) async {
    try {
      setStatus(Status.loading);
      await asyncFunction();
      setStatus(Status.success);
    } catch (e) {
      setError(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
} 
import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;
  
  setToken(String token) {
    _token = token;
    notifyListeners();
  }
}
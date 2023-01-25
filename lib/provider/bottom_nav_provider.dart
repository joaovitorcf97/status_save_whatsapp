import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void changePage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}

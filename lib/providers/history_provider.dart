import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider extends ChangeNotifier {
  List<String> _imagePaths = [];
  List<String> get imagePaths => _imagePaths;

  HistoryProvider() {
    loadHistory();
  }

  Future<void> saveHistory(String savedPath) async {
    _imagePaths.add(savedPath); //imagePaths list add image path
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listHistyory', _imagePaths);
    notifyListeners();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _imagePaths = prefs.getStringList('listHistyory') ?? [];
    notifyListeners();
  }
}

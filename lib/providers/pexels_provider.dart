import 'package:dream_wall/api/api.dart';
import 'package:dream_wall/models/pages.dart';
import 'package:flutter/material.dart';

class PexelsProvider with ChangeNotifier {
  List<Pages> _pages;

  List<Pages> get pages {
    if (_pages == null) {
      refresh();
    }
    return _pages ?? [];
  }

  Future<void> refresh() async {
    final response = await api.get("curated?per_page=50&page=1");
    if (response?.statusCode == 200) {
      _pages = (response.data["data"] as List)
          .map((e) => Pages.fromJson(e))
          .toList();
      notifyListeners();
      return;
    }
  }

  Future<List<Pages>> searchPages(String query) async {
    final response = await api.get("search?query=$query&per_page=80&page=1");
    if (response.statusCode == 200 && response.data["success"]) {
      return (response.data["data"] as List)
          .map((e) => Pages.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<List<Pages>> getPhotoById(String id) async {
    final response = await api.get("photos/$id");
    if (response.statusCode == 200 && response.data["success"]) {
      return (response.data["data"] as List)
          .map((e) => Pages.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<List<Pages>> getRandom({String page}) async {
    final response = await api.get("curated?per_page=1&page=$page");
    if (response.statusCode == 200 && response.data["success"]) {
      return (response.data["data"] as List)
          .map((e) => Pages.fromJson(e))
          .toList();
    }

    return [];
  }
}

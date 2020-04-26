import 'package:dream_wall/api/api.dart';
import 'package:dream_wall/models/pages.dart';
import 'package:flutter/material.dart';

class PexelsProvider with ChangeNotifier {
  Future<Pages> getPhotos() async {
    final response = await api.get("curated?per_page=15&page=1");
    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
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

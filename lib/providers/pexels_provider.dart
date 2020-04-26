import 'package:dream_wall/api/api.dart';
import 'package:dream_wall/models/pages.dart';
import 'package:flutter/material.dart';

class PexelsProvider with ChangeNotifier {
  Future<Pages> getPhotos() async {
    final response = await api.get("curated?per_page=50&page=1");
    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
  }

  Future<Pages> getOther(int other) async {
    final response =
        await api.get("curated?per_page=30&page=$other");
    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
  }

  Future<Pages> searchPages(String query) async {
    final response = await api.get("search?query=$query&per_page=50&page=1");

    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
  }
}

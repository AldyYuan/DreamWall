import 'package:dream_wall/api/api.dart';
import 'package:dream_wall/models/pages.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PexelsProvider with ChangeNotifier {
  Future<Pages> getPhotos() async {
    final response = await api.get("curated?per_page=15&page=1");
    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
  }

  Future<Pages> getOther() async {
    var random = new Random();
    final response =
        await api.get("curated?per_page=15&page=${random.nextInt(1000)}");
    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
  }

  Future<Pages> searchPages(String query) async {
    final response = await api.get("search?query=$query&per_page=80&page=1");

    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
  }

  Future<Pages> getPhotoById(double id) async {
    final response = await api.get("photos/$id");

    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
  }

  Future<Pages> getRandom() async {
    var random = new Random();
    final response =
        await api.get("curated?per_page=1&page=${random.nextInt(1000)}");

    if (response.statusCode == 200) {
      return Pages.fromJson(response.data);
    }
    return null;
  }
}

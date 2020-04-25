import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

String accessToken = "563492ad6f91700001000001f885c3f8f3994adc9edebb62a80247c9";

decodeJson(String data) {
  return json.decode(data);
}

final api = Dio(
  BaseOptions(
      baseUrl: "https://api.pexels.com/v1/",
      connectTimeout: 15 * 1000,
      sendTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
      receiveDataWhenStatusError: true,
      followRedirects: true),
)
  ..transformer = DefaultTransformer(jsonDecodeCallback: (s) {
    return compute(decodeJson, s);
  })
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options) {
      if (accessToken == null) {
        options.headers.addAll({
          "Authorization": accessToken,
        });
      }
    },
    onResponse: (e) async {
      if (e.statusCode == 200) {
        if (e.data is String && (e.data as String).isNotEmpty) {
          final String jsonString = e.data;
          e.data = await compute(decodeJson, jsonString);
        }
      }
    },
  ));

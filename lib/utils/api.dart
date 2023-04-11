import 'dart:convert';

import 'package:emovied/models/search.dart';
import 'package:emovied/models/show.dart';
import 'package:http/http.dart' as http;

class TheMovieDBAPI {
  static Future<http.Response?> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  static Future<List<Shows>> fetchShowsData(String url) async {
    final response = await TheMovieDBAPI.fetchData(url);
    if (response != null) {
      final data = json.decode(response.body);
      final moviesResponse = (data['results'] as List).map((e) => Shows.fromJson(e)).toList();
      return moviesResponse;
    }
    return [];
  }

  static Future<List<MultiSearch>> fetchSearchData(String url) async {
    final response = await TheMovieDBAPI.fetchData(url);
    if (response != null) {
      final data = json.decode(response.body);
      final searchResponse = (data['results'] as List).map((e) => MultiSearch.fromJson(e)).toList();
      return searchResponse;
    }
    return [];
  }
}

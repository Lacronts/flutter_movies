import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:http/http.dart' as http;

const Map<EEntertainmentType, String> _typeToURLPath = {
  EEntertainmentType.Movie: 'movie',
  EEntertainmentType.TV: 'tv',
};

class MovieRepositories {
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const apiKey = 'b54f9e3012f1111008639b65a8a7a83a';
  final language = 'ru-RU';

  const MovieRepositories();

  String get _queryOptions => 'api_key=$apiKey&region=RU';

  String get _language => 'language=$language';

  Future<List<dynamic>> loadNowPlaying({page = 1}) async {
    final results = await http
        .get('$baseUrl/movie/now_playing?page=$page&$_queryOptions&$_language');
    if (results.statusCode != 200) {
      throw new Exception('error getting now playing');
    }

    final json = jsonDecode(results.body);

    return json["results"];
  }

  Future<List<dynamic>> loadUpcomingMovies({page = 1}) async {
    final results = await http
        .get('$baseUrl/movie/upcoming?page=$page&$_queryOptions&$_language');
    if (results.statusCode != 200) {
      throw new Exception('error getting now playing');
    }

    final json = jsonDecode(results.body);

    return json["results"];
  }

  Future<List<dynamic>> loadTopRated({page = 1}) async {
    final results = await http
        .get('$baseUrl/movie/top_rated?page=$page&$_queryOptions&$_language');
    if (results.statusCode != 200) {
      throw new Exception('error getting top rated');
    }

    final json = jsonDecode(results.body);

    return json["results"];
  }

  Future<List<dynamic>> loadGenres() async {
    final results =
        await http.get('$baseUrl/genre/movie/list?$_queryOptions&$_language');
    if (results.statusCode != 200) {
      throw new Exception('error getting genres');
    }

    final json = jsonDecode(results.body);

    return json["genres"];
  }

  Future<dynamic> getEntertainmentDetailsById({
    @required int id,
    @required EEntertainmentType type,
  }) async {
    final results = await http
        .get('$baseUrl/${_typeToURLPath[type]}/$id?$_queryOptions&$_language');

    if (results.statusCode != 200) {
      throw new Exception('error getting entertainment details');
    }

    final json = jsonDecode(results.body);

    return json;
  }

  Future<List<dynamic>> getEntertainmentImagesById({
    @required int id,
    @required EEntertainmentType type,
  }) async {
    final String selectedType = _typeToURLPath[type];
    final results = await http
        .get('$baseUrl/$selectedType/$id/images?$_queryOptions&language=null');
    if (results.statusCode != 200) {
      throw new Exception('error getting entertainment images');
    }

    final json = jsonDecode(results.body);

    return json["backdrops"];
  }

  Future<List<dynamic>> getTrailerById({
    @required int id,
    @required EEntertainmentType type,
  }) async {
    final results = await http.get(
        '$baseUrl/${_typeToURLPath[type]}/$id/videos?$_queryOptions$_language');

    if (results.statusCode != 200) {
      throw new Exception('error getting trailer by id');
    }

    final json = jsonDecode(results.body);

    return json["results"];
  }

  Future<Map<String, dynamic>> getCastsByEntertainmentId({
    @required int id,
    @required EEntertainmentType type,
  }) async {
    final results = await http.get(
        '$baseUrl/${_typeToURLPath[type]}/$id/credits?$_queryOptions&$_language');

    if (results.statusCode != 200) {
      print(results.request);
      throw new Exception('error getting entertainment cast');
    }

    return jsonDecode(results.body);
  }

  Future<dynamic> getCastDetailsByCastId(int castId) async {
    final results =
        await http.get('$baseUrl/person/$castId?$_queryOptions&$_language');

    if (results.statusCode != 200) {
      throw new Exception('error getting cast details');
    }

    return jsonDecode(results.body);
  }

  Future<dynamic> getPersonImagesByCastId(int castId) async {
    final results = await http
        .get('$baseUrl/person/$castId/images?$_queryOptions&$_language');

    if (results.statusCode != 200) {
      throw new Exception('error getting person images');
    }

    return jsonDecode(results.body)['profiles'];
  }

  Future<dynamic> getMovieCreditsByCastId(int castId) async {
    final results = await http
        .get('$baseUrl/person/$castId/movie_credits?$_queryOptions&$_language');

    if (results.statusCode != 200) {
      throw new Exception('error getting movie credits');
    }

    return jsonDecode(results.body)['cast'];
  }

  Future<dynamic> getTVCreditsByCastId(int castId) async {
    final results = await http
        .get('$baseUrl/person/$castId/tv_credits?$_queryOptions&$_language');

    if (results.statusCode != 200) {
      throw new Exception('error getting tv credits');
    }

    return jsonDecode(results.body)['cast'];
  }

  Future<List<dynamic>> getUserReviewsById({
    @required int id,
    @required EEntertainmentType type,
  }) async {
    final results = await http
        .get('$baseUrl/${_typeToURLPath[type]}/$id/reviews?$_queryOptions');

    if (results.statusCode != 200) {
      throw new Exception('error getting user reviews');
    }

    return jsonDecode(results.body)["results"];
  }

  Future<List<dynamic>> getRecommendationsById({
    @required int id,
    @required EEntertainmentType type,
  }) async {
    final results = await http.get(
        '$baseUrl/${_typeToURLPath[type]}/$id/recommendations?$_queryOptions&$_language');

    if (results.statusCode != 200) {
      throw new Exception('error getting recommendations');
    }

    return jsonDecode(results.body)["results"];
  }
}

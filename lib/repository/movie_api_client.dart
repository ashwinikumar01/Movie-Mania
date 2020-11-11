import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/constants/constants.dart';

import 'package:movie_app/model/movie_discover.dart';

class MovieApiClient {
  static const baseUrl = 'https://api.themoviedb.org/3';
  String query;

  Dio _dio;
  MovieApiClient() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: baseUrl);
    _dio = Dio(options);
  }

  Future<MovieDiscover> getAllData() async {
    try {
      final response = await _dio.get(baseUrl +
          '/discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1');
      return MovieDiscover.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }

  getPopularData() async {
    http.Response response = await http.get(
      '$baseUrl/movie/popular?api_key=$API_KEY&language=en-US&page=10',
    );
    return json.decode(response.body);
  }

  getTopRatedData() async {
    http.Response response = await http.get(
      '$baseUrl/movie/top_rated?api_key=$API_KEY&language=en-US&page=8',
    );
    return json.decode(response.body);
  }

  getTrendingMovieOfWeek() async {
    http.Response response =
        await http.get('$baseUrl/trending/movie/week?api_key=$API_KEY');
    return json.decode(response.body);
  }

  getUpcomingMovies() async {
    http.Response response = await http
        .get('$baseUrl/movie/upcoming?api_key=$API_KEY&language=en-US&page=1');
    return json.decode(response.body);
  }

  getNowPlayingMovies() async {
    http.Response response = await http.get(
        '$baseUrl/movie/now_playing?api_key=$API_KEY&language=en-US&page=2&region=us');
    return json.decode(response.body);
  }

  searchMovies() async {
    http.Response response = await http
        .get('$baseUrl/search/company?api_key=$API_KEY&query=$query&page=1');
    return json.decode(response.body);
  }

  getGenres() async {
    http.Response response = await http
        .get('$baseUrl/genre/movie/list?api_key=$API_KEY&language=en-US');
    return json.decode(response.body);
  }
}

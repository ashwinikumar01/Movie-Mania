import 'package:dio/dio.dart';

import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/model/movie_discover.dart';

import 'package:movie_app/model/popular_movies.dart';

class MovieApiClient {
  static const baseUrl = 'https://api.themoviedb.org';
  int page;
  int pagge;
  Dio _dio;
  MovieApiClient() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: baseUrl);
    _dio = Dio(options);
  }

  Future<MovieDiscover> getAllData() async {
    try {
      final response = await _dio.get(
        '$baseUrl/3/discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=7',
      );

      return MovieDiscover.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }

  Future<PopularMovies> getPopularMovies() async {
    try {
      final response = await _dio.get(
        '$baseUrl/3/movie/popular?api_key=$API_KEY&language=en-US&page=9',
      );

      return PopularMovies.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }
}

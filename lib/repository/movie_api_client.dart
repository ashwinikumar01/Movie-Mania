import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/model/movie_discover.dart';
import 'dart:convert';

class MovieApiClient {
  static const baseUrl = 'https://api.themoviedb.org';
  int page;
  Dio _dio;
  MovieApiClient() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000, connectTimeout: 100000, baseUrl: baseUrl);
    _dio = Dio(options);
  }

  Future<MovieDiscover> getAllData() async {
    try {
      final response = await _dio.get(
          '$baseUrl/3/discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');

      return MovieDiscover.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }

  fetchTotalData(int page) async {
    http.Response response = await http.get(
        '$baseUrl/3/discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    print(response.body);
    return json.decode(response.body);
  }
}

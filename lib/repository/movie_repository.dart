import 'package:meta/meta.dart';
import 'package:movie_app/model/movie_discover.dart';

import 'package:movie_app/repository/movie_api_client.dart';

class MovieRepository {
  final MovieApiClient movieApiClient;
  MovieRepository({@required this.movieApiClient});

  Future<MovieDiscover> getAllData() async {
    return movieApiClient.getAllData();
  }

  getPopularData() async {
    return movieApiClient.getPopularData();
  }

  getTopRatedData() async {
    return movieApiClient.getTopRatedData();
  }

  getTrendingOfWeek() async {
    return movieApiClient.getTrendingMovieOfWeek();
  }

  getUpcomingMovies() async {
    return movieApiClient.getUpcomingMovies();
  }
}

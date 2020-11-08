import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/model/movie_discover.dart';
import 'package:movie_app/repository/movie_repository.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class MovieRequested extends MovieEvent {
  @override
  List<Object> get props => [];
}

class MovieRefreshRequested extends MovieEvent {
  @override
  List<Object> get props => [];
}

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends MovieState {}

class MovieLoadInProgress extends MovieState {}

class MovieLoadSuccess extends MovieState {
  final MovieDiscover movieDiscover;
  final popularData;
  final topRatedData;
  final trending;
  final upcomingMovies;

  MovieLoadSuccess({
    @required this.movieDiscover,
    @required this.popularData,
    @required this.topRatedData,
    @required this.trending,
    @required this.upcomingMovies,
  });

  @override
  List<Object> get props => [
        movieDiscover,
        popularData,
        topRatedData,
        trending,
        upcomingMovies,
      ];
}

class MovieLoadFailure extends MovieState {}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc({@required this.movieRepository})
      : assert(movieRepository != null),
        super(null);

  // @override
  // Stream<MovieState> mapEventToState(
  //   MovieEvent event,
  // ) async* {
  //   if (event is MovieRequested) {
  //     yield* _mapFetchCaseToState(event);
  //   }
  // }

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is MovieRequested) {
      yield* _mapFetchCaseToState(event);
    } else if (event is MovieRefreshRequested) {
      yield* _mapCovidRefreshRequestedToState(event);
    }
  }

  Stream<MovieState> _mapFetchCaseToState(MovieEvent event) async* {
    yield MovieLoadInProgress();

    final allData = await movieRepository.getAllData();
    final populaarData = await movieRepository.getPopularData();
    final topRatedData = await movieRepository.getTopRatedData();
    final trending = await movieRepository.getTrendingOfWeek();
    final upcomingMovies = await movieRepository.getUpcomingMovies();
    try {
      yield MovieLoadSuccess(
        movieDiscover: allData,
        popularData: populaarData,
        topRatedData: topRatedData,
        trending: trending,
        upcomingMovies: upcomingMovies,
      );
    } catch (_) {
      yield MovieLoadFailure();
    }
  }

  Stream<MovieState> _mapCovidRefreshRequestedToState(
    MovieRefreshRequested event,
  ) async* {
    try {
      final allData = await movieRepository.getAllData();
      final populaarData = await movieRepository.getPopularData();
      final topRatedData = await movieRepository.getTopRatedData();
      final trending = await movieRepository.getTrendingOfWeek();
      final upcomingMovies = await movieRepository.getUpcomingMovies();
      yield MovieLoadSuccess(
        movieDiscover: allData,
        popularData: populaarData,
        topRatedData: topRatedData,
        trending: trending,
        upcomingMovies: upcomingMovies,
      );
    } catch (_) {}
  }
}

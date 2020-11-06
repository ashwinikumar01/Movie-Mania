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

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends MovieState {}

class MovieLoadInProgress extends MovieState {}

class MovieLoadSuccess extends MovieState {
  final MovieDiscover movieDiscover;

  MovieLoadSuccess({
    @required this.movieDiscover,
  });

  @override
  List<Object> get props => [movieDiscover];
}

class MovieLoadFailure extends MovieState {}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc({@required this.movieRepository})
      : assert(movieRepository != null),
        super(null);

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is MovieRequested) {
      yield* _mapFetchCaseToState(event);
    }
  }

  Stream<MovieState> _mapFetchCaseToState(MovieEvent event) async* {
    yield MovieLoadInProgress();
    final movieData = await movieRepository.getAllData();
    try {
      yield MovieLoadSuccess(
        movieDiscover: movieData,
      );
    } catch (_) {
      yield MovieLoadFailure();
    }
  }
}
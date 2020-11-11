import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/repository/movie_repository.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();
}

class GenreRequested extends GenreEvent {
  @override
  List<Object> get props => [];
}

class GenreRefreshRequested extends GenreEvent {
  @override
  List<Object> get props => [];
}

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreEmpty extends GenreState {}

class GenreLoadInProgress extends GenreState {}

class GenreLoadSuccess extends GenreState {
  final Genre genre;

  GenreLoadSuccess({
    @required this.genre,
  });

  @override
  List<Object> get props => [
        genre,
      ];
}

class GenreLoadFailure extends GenreState {}

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final MovieRepository movieRepository;
  GenreBloc({@required this.movieRepository})
      : assert(movieRepository != null),
        super(null);

  @override
  Stream<GenreState> mapEventToState(
    GenreEvent event,
  ) async* {
    if (event is GenreRequested) {
      yield* _mapFetchCaseToState(event);
    } else if (event is GenreRefreshRequested) {
      yield* _mapGenreRefreshRequestedToState(event);
    }
  }

  Stream<GenreState> _mapFetchCaseToState(GenreEvent event) async* {
    yield GenreLoadInProgress();

    try {
      yield GenreLoadSuccess();
    } catch (_) {
      yield GenreLoadFailure();
    }
  }

  Stream<GenreState> _mapGenreRefreshRequestedToState(
    GenreRefreshRequested event,
  ) async* {
    try {
      yield GenreLoadSuccess();
    } catch (_) {}
  }
}

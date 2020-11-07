import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/repository/movie_api_client.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/simple_bloc_observer.dart';
import 'package:movie_app/ui/home_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final MovieRepository movieRepository =
      MovieRepository(movieApiClient: MovieApiClient());

  runApp(
    App(movieRepository: movieRepository),
  );
}

class App extends StatelessWidget {
  final MovieRepository movieRepository;

  App({Key key, @required this.movieRepository})
      : assert(movieRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MovieBloc(movieRepository: movieRepository),
        child: HomeScreen(),
      ),
    );
  }
}

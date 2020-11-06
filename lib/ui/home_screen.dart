import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/model/popular_movies.dart';
import 'package:movie_app/widget/discover_card.dart';
import 'package:movie_app/widget/loader.dart';
import 'package:movie_app/widget/movies_list_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<MovieBloc>(context).add(MovieRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Movie Mania',
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          )),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadInProgress) {
            return Loader();
          }
          if (state is MovieLoadSuccess) {
            final movieData = state.movieDiscover;
            final popularMovies = state.popularMovies;

            return movieData.results.length == null
                ? CircularProgressIndicator()
                : ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      DiscoverCard(movieData: movieData),
                      MoviesListCard(popularMovies: popularMovies),
                      MoviesListCard(popularMovies: popularMovies),
                    ],
                  );
          }
          if (state is MovieLoadFailure) {
            return Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
            );
          }

          return Loader();
        },
      ),
    );
  }
}

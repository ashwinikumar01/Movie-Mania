import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/movie_bloc.dart';

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
    final query = MediaQuery.of(context).size.height;
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
            final allData = state.movieDiscover;
            final popularDataa = state.popularData;
            final topData = state.topRatedData;
            final trending = state.trending;

            return allData == null
                ? CircularProgressIndicator()
                : ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      DiscoverCard(query: query, allData: allData),
                      MoviesListCard(
                        title: 'Popular Movies',
                        allData: allData,
                        data: popularDataa,
                      ),
                      MoviesListCard(
                        title: 'Top Rated Movies',
                        allData: allData,
                        data: topData,
                      ),
                      MoviesListCard(
                        title: 'Trending',
                        allData: allData,
                        data: trending,
                      ),
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

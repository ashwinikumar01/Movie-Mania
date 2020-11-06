import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/widget/discover_card.dart';

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
            color: Colors.white70,
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MovieLoadSuccess) {
            final movieData = state.movieDiscover;
            final popularMovies = state.popularMovies;
            return movieData.results.length == null
                ? CircularProgressIndicator()
                : ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: <Widget>[
                      DiscoverCard(movieData: movieData),
                      // Center(
                      //   child: Text(
                      //    similarMovies,
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // )
                    ],
                  );
          }
          if (state is MovieLoadFailure) {
            return Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// SizedBox(
//                     width: double.infinity,
//                     height: 200.0,
//                     child: Column(
//                       children: <Widget>[
//                         Expanded(
//                           child: Swiper(
//                             // itemCount: movieData.results.length,
//                             viewportFraction: 0.75,
//                             scale: 0.9,
//                             scrollDirection: Axis.horizontal,
//                             itemCount: movieData.results.length,
//                             itemBuilder: (context, index) {
//                               return ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: FadeInImage(
//                                   image: CachedNetworkImageProvider(
//                                     IMAGE_URL +
//                                         movieData.results[index].posterPath,
//                                   ),
//                                   fit: BoxFit.cover,
//                                   placeholder: AssetImage('assets/loading.gif'),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   )

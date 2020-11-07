import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/constants/constants.dart';
// import 'package:movie_app/constants/constants.dart';
// import 'package:movie_app/model/popular_movies.dart';
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

            return allData == null
                ? CircularProgressIndicator()
                : ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: query / 2.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 2.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Discover',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Swiper(
                                itemCount: allData.results.length,
                                viewportFraction: 0.75,
                                scale: 0.9,
                                autoplay: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: FadeInImage(
                                      image: CachedNetworkImageProvider(
                                          IMAGE_URL +
                                              allData
                                                  .results[index].posterPath),
                                      fit: BoxFit.cover,
                                      placeholder:
                                          AssetImage('assets/loading.gif'),
                                      placeholderErrorBuilder:
                                          (context, url, error) =>
                                              Icon(Icons.error),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.0,
                              top: 14.0,
                            ),
                            child: Text(
                              'Popular',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 3.8,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: allData.results.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.9,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: FadeInImage(
                                              image: CachedNetworkImageProvider(
                                                IMAGE_URL +
                                                    popularDataa['results']
                                                        [index]['poster_path'],
                                              ),
                                              fit: BoxFit.cover,
                                              placeholder: AssetImage(
                                                'assets/loading.gif',
                                              ),
                                              placeholderErrorBuilder:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          popularDataa['results'][index]
                                              ['original_title'],
                                          style: GoogleFonts.openSans(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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

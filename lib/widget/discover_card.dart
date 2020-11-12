import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/model/movie_discover.dart';
import 'package:movie_app/widget/movie_details.dart';

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    Key key,
    @required this.query,
    @required this.allData,
    //  @required this.movieData,
  }) : super(key: key);

  final double query;
  final MovieDiscover allData;
  // final movieData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetails(
                        dataa: allData.results[index],
                        // result: allData.results,
                        // // data: movieData,
                        // // result: allData.results,
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage(
                      image: CachedNetworkImageProvider(
                          IMAGE_URL + allData.results[index].posterPath),
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/loading.gif'),
                      placeholderErrorBuilder: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

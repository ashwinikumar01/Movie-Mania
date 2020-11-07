import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/model/movie_discover.dart';

class DiscoverCard extends StatelessWidget {
  final MovieDiscover movieDiscover;

  DiscoverCard({Key key, this.movieDiscover});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size.height;
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
              itemCount: movieDiscover.results.length,
              viewportFraction: 0.75,
              scale: 0.9,
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    image: CachedNetworkImageProvider(
                        IMAGE_URL + movieDiscover.results[index].posterPath),
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/loading.gif'),
                    placeholderErrorBuilder: (context, url, error) =>
                        Icon(Icons.error),
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

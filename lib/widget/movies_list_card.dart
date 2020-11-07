import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/model/movie_discover.dart';
import 'package:shimmer/shimmer.dart';

class MoviesListCard extends StatelessWidget {
  const MoviesListCard({
    Key key,
    @required this.allData,
    @required this.data,
    @required this.title,
  }) : super(key: key);

  final MovieDiscover allData;
  final data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            top: 14.0,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.blue,
            child: Text(
              title,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
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
                width: MediaQuery.of(context).size.width / 2.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FadeInImage(
                            image: CachedNetworkImageProvider(
                              IMAGE_URL + data['results'][index]['poster_path'],
                            ),
                            fit: BoxFit.cover,
                            placeholder: AssetImage(
                              'assets/loading.gif',
                            ),
                            placeholderErrorBuilder: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        data['results'][index]['original_title'],
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
    );
  }
}

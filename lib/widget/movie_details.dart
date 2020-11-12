import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/constants.dart';

class MovieDetails extends StatelessWidget {
  final dataa;
  MovieDetails({
    this.dataa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: CachedNetworkImageProvider(
              IMAGE_URL + dataa.posterPath,
            ),
            fit: BoxFit.cover,
            placeholder: AssetImage(
              'assets/loading.gif',
            ),
            placeholderErrorBuilder: (context, url, error) => Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}

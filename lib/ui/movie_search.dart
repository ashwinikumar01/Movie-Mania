import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/movie_discover.dart';

class MovieSearch extends SearchDelegate<Result> {
  final List<Genre> genres;
  MovieSearch({this.genres});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              Icons.search,
              size: 50,
              color: Colors.white,
            ),
          ),
          Text(
            'Enter a Movie to search.',
          )
        ],
      )),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}

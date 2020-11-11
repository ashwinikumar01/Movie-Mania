import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/movie_discover.dart';

class MovieSearch extends SearchDelegate {
  List<MovieDiscover> movieDiscover;

  MovieSearch(this.movieDiscover);
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.lightGreen,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
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
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
        // @override
        // void initState() {
        //   super.initState();

        // }
        child: ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return Text(movieDiscover[index].results[index].originalTitle);
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container(
      color: Colors.black,
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
              color: Colors.black,
            ),
          ),
          Text(
            'Enter a Movie to search.',
          )
        ],
      )),
    );
  }
}

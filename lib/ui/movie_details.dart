import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/constants.dart';
import 'package:movie_app/model/movie_discover.dart';

class MovieDetails extends StatelessWidget {
  final data;
  final MovieDiscover movieDiscover;
  MovieDetails({
    this.data,
    this.movieDiscover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
              itemCount: movieDiscover.results.length,
              itemBuilder: (context, index) {
                return Text(data['results'][index]['original_title']);
              }),
          // FadeInImage(
          //   image: CachedNetworkImageProvider(
          //     IMAGE_URL + data['results'][0]['poster_path'],
          //   ),
          //   fit: BoxFit.cover,
          //   placeholder: AssetImage(
          //     'assets/loading.gif',
          //   ),
          //   placeholderErrorBuilder: (context, url, error) => Icon(Icons.error),
          // ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/bloc/movie_bloc.dart';
// import 'package:movie_app/model/movie_discover.dart';
// import 'package:movie_app/widget/loader.dart';

// class MovieDetails extends StatefulWidget {
//   @override
//   _MovieDetailsState createState() => _MovieDetailsState();
// }

// class _MovieDetailsState extends State<MovieDetails> {
//   @override
//   void didChangeDependencies() {
//     BlocProvider.of<MovieBloc>(context).add(MovieRequested());
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('gg'),
//       ),
//       body: BlocBuilder(
//         cubit: movieBloc,
//         builder: (BuildContext context, MovieState state) {
//           if (state is MovieLoadInProgress) {
//             return Loader();
//           }
//           if (state is MovieLoadSuccess) {
//             final dataa = state.movieDiscover;
//             return Column(
//               children: <Widget>[Text(dataa.results[0].originalTitle)],
//             );
//           }
//           if (state is MovieLoadFailure) {
//             return Center(
//               child: Text(
//                 'Something went wrong!',
//                 style: TextStyle(color: Colors.red),
//               ),
//             );
//           }

//           return Loader();
//         },
//       ),
//     );
//   }
// }

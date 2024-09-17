import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieItem({Key? key, required this.movie, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
        width: 50,
        fit: BoxFit.cover,
      ),
      title: Text(movie.title),
      subtitle: Text('Rating: ${movie.voteAverage}'),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final void Function(Movie movie) onMovieTap;
  final void Function()? onSeeAllTap; // Nuevo callback para la flechita

  const MovieSection({
    Key? key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
    this.onSeeAllTap, // Aceptar el callback opcional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de la sección con la flechita
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: onSeeAllTap, // Redirigir a la lista completa
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Lista horizontal de películas
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () => onMovieTap(movie),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.title,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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

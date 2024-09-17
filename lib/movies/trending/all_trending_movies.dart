import 'package:flutter/material.dart';
import 'package:pelisflix/models/movie.dart';
import 'package:pelisflix/movies/movie_detail_screen.dart';
import 'package:pelisflix/services/tmdb_service.dart';
import 'package:pelisflix/widgets/movie_item.dart';

class AllTrendingMoviesPage extends StatefulWidget {
  const AllTrendingMoviesPage({Key? key}) : super(key: key);

  @override
  State<AllTrendingMoviesPage> createState() => _AllTrendingMoviesPageState();
}

class _AllTrendingMoviesPageState extends State<AllTrendingMoviesPage> {
  final TMDbService _tmdbService = TMDbService();
  List<Movie> _trendingMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrendingMovies();
  }

  Future<void> _loadTrendingMovies() async {
    try {
      final movies = await _tmdbService.getTrendingMovies();
      setState(() {
        _trendingMovies = movies;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading trending movies: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Películas en Tendencia')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _trendingMovies.length,
        itemBuilder: (context, index) {
          final movie = _trendingMovies[index];
          return MovieItem(
            movie: movie,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

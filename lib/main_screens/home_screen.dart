import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelisflix/movies/movie_detail_screen.dart';
import 'package:pelisflix/user/user_details.dart';
import '../models/movie.dart';
import '../services/tmdb_providers.dart';
import '../widgets/movie_section.dart';
// Actor model is not used directly here anymore, popularActorsProvider is available if needed on other screens.

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _onMovieTap(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie),
      ),
    );
  }

  void _onSeeAllTrendingMovies(BuildContext context) {
    Navigator.pushNamed(context, '/trendingMovies');
  }

  void _onSeeAllLatestTrailers(BuildContext context) {
    Navigator.pushNamed(context, '/latestTrailers');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingMoviesAsync = ref.watch(trendingMoviesProvider);
    final latestTrailersAsync = ref.watch(latestTrailersProvider);
    // popularActorsProvider is not watched here as it's not directly displayed.
    // The 'Actores populares' button navigates to a screen that can consume it.

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hola, Oscar!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDetailsScreen()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 20,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            'Peliculas',
                            'Series',
                            'Actores populares',
                          ].map((category) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (category == 'Peliculas') {
                                  Navigator.pushNamed(context, '/grid');
                                } else if (category == 'Actores populares') {
                                  Navigator.pushNamed(context, '/actors');
                                } else {
                                  Navigator.pushNamed(context, '/series');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              child: Text(category),
                            ),
                          )).toList(),
                        ),
                      ),
                    ),
                    trendingMoviesAsync.when(
                      data: (movies) => MovieSection(
                        title: 'En tendencia',
                        movies: movies,
                        onMovieTap: (movie) => _onMovieTap(context, movie),
                        onSeeAllTap: () => _onSeeAllTrendingMovies(context),
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                    ),
                    latestTrailersAsync.when(
                      data: (trailers) => MovieSection(
                        title: 'Últimos trailers',
                        movies: trailers, // Assuming MovieSection can also display Trailers if they share common fields or adapt MovieSection
                        onMovieTap: (movie) => _onMovieTap(context, movie), // This might need adjustment if Trailer objects are different
                        onSeeAllTap: () => _onSeeAllLatestTrailers(context),
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.local_activity), label: 'Actividad'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mi lista'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on home, or navigate to '/home' if it's a different route instance
              if (ModalRoute.of(context)?.settings.name != '/home') {
                Navigator.pushNamed(context, '/home');
              }
              break;
            case 1:
              Navigator.pushNamed(context, '/activity');
              break;
            case 2:
              Navigator.pushNamed(context, '/myList');
              break;
            case 3:
              Navigator.pushNamed(context, '/search');
              break;
          }
        },
      ),
    );
  }
}

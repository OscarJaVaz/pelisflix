import 'package:flutter/material.dart';
import 'package:pelisflix/actors/popular_actors_grid_page.dart';
import 'package:pelisflix/models/person.dart';
import 'package:pelisflix/movies/movie_detail_screen.dart';
import 'package:pelisflix/user/user_details.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import '../widgets/movie_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TMDbService _tmdbService = TMDbService();
  List<Movie> _trendingMovies = [];
  List<Movie> _latestTrailers = [];
  List<Person> _popularActors = [];

  @override
  void initState() {
    super.initState();
    _loadTrendingMovies();
    _loadLatestTrailers();
    _loadPopularActors();
  }

  Future<void> _loadTrendingMovies() async {
    try {
      final movies = await _tmdbService.getTrendingMovies();
      setState(() {
        _trendingMovies = movies;
      });
    } catch (e) {
      print('Error loading trending movies: $e');
    }
  }

  Future<void> _loadLatestTrailers() async {
    try {
      final trailers = await _tmdbService.getLatestTrailers();
      setState(() {
        _latestTrailers = trailers;
      });
    } catch (e) {
      print('Error loading latest trailers: $e');
    }
  }

  Future<void> _loadPopularActors() async {
    try {
      final actors = await _tmdbService.getPopularActors();
      setState(() {
        _popularActors = actors;
      });
    } catch (e) {
      print('Error loading popular actors: $e');
    }
  }

  void _onMovieTap(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie),
      ),
    );
  }

  // Funciones para redirigir a las listas completas
  void _onSeeAllTrendingMovies() {
    Navigator.pushNamed(context, '/trendingMovies'); // Asegúrate de que la ruta esté definida
  }

  void _onSeeAllLatestTrailers() {
    Navigator.pushNamed(context, '/latestTrailers'); // Asegúrate de que la ruta esté definida
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
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
                      // Redirige a la pantalla de detalles del usuario
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDetailsScreen()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white),
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
                    // Sección de películas en tendencia
                    MovieSection(
                      title: 'En tendencia',
                      movies: _trendingMovies,
                      onMovieTap: _onMovieTap,
                      onSeeAllTap: _onSeeAllTrendingMovies, // Callback para la flechita
                    ),
                    // Sección de últimos trailers
                    MovieSection(
                      title: 'Últimos trailers',
                      movies: _latestTrailers,
                      onMovieTap: _onMovieTap,
                      onSeeAllTap: _onSeeAllLatestTrailers, // Callback para la flechita
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
          selectedItemColor: Colors.white, // Color para el ítem seleccionado
          unselectedItemColor: Colors.white.withOpacity(0.6), // Color para los ítems no seleccionados
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.local_activity), label: 'Actividad'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mi lista'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          ],
        ),
    );
  }
}

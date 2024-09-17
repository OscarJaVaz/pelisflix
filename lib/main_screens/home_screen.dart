import 'package:flutter/material.dart';
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
      });
    } catch (e) {
      print('Error loading trending movies: $e');
      // TODO: Implement proper error handling
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hola, Oscar!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  CircleAvatar(backgroundColor: Colors.grey[300], radius: 20),
                ],
              ),
            ),
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Categories
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
                                } else {
                                  Navigator.pushNamed(context, '/series');
                                  // Aquí puedes agregar otras acciones para 'Series' y 'Actores populares'
                                  print('Botón $category presionado');
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
                    // Trending movies section
                    MovieSection(title: 'En tendencia', movies: _trendingMovies),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
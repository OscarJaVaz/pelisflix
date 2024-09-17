import 'package:flutter/material.dart';
import 'package:pelisflix/main_screens/home_screen.dart';
import 'package:pelisflix/services/tmdb_service.dart';
import 'package:pelisflix/models/movie.dart';

class SelectFavoritesScreen extends StatefulWidget {
  const SelectFavoritesScreen({Key? key}) : super(key: key);

  @override
  _SelectFavoritesScreenState createState() => _SelectFavoritesScreenState();
}

class _SelectFavoritesScreenState extends State<SelectFavoritesScreen> {
  final TMDbService _tmdbService = TMDbService();
  List<Movie> _movies = [];
  List<Movie> _selectedMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  // Obtener películas populares desde el servicio TMDb
  void _fetchMovies() async {
    try {
      List<Movie> movies = await _tmdbService.getPopularMovies();
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      // Manejo de errores
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Función para seleccionar o deseleccionar películas
  void _toggleSelection(Movie movie) {
    setState(() {
      if (_selectedMovies.contains(movie)) {
        _selectedMovies.remove(movie);
      } else if (_selectedMovies.length < 5) {
        _selectedMovies.add(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(46.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "¿Qué tipo de películas y series te gustan?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Escoge 5"),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  final isSelected = _selectedMovies.contains(movie);
                  return GestureDetector(
                    onTap: () => _toggleSelection(movie),
                    child: GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.red : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _selectedMovies.length == 5
                    ? () {
                  // Navegar a la pantalla HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  print("Movies selected: ${_selectedMovies.map((e) => e.title).toList()}");
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                ),
                child: const Text("Hecho"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

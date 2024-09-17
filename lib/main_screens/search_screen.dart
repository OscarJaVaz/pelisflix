import 'package:flutter/material.dart';
import 'package:pelisflix/movies/movie_detail_screen.dart';
import '../services/tmdb_service.dart';
import '../models/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TMDbService _tmdbService = TMDbService();
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  bool _isLoading = false;
  String _selectedCategory = 'Popular'; // categoria por defecto
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Movie> movies;
      switch (_selectedCategory) {
        case 'Trending':
          movies = await _tmdbService.getTrendingMovies();
          break;
        case 'Popular':
          movies = await _tmdbService.getPopularMovies();
          break;
        case 'Now Playing':
          movies = await _tmdbService.getLatestTrailers();
          break;
        default:
          movies = await _tmdbService.getPopularMovies();
      }
      setState(() {
        _movies = movies;
        _filteredMovies = _filterMovies(movies, _searchQuery);
      });
    } catch (e) {
      print('Error loading movies: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Movie> _filterMovies(List<Movie> movies, String query) {
    if (query.isEmpty) {
      return movies;
    }
    return movies.where((movie) {
      final titleLower = movie.title.toLowerCase();
      final queryLower = query.toLowerCase();
      return titleLower.contains(queryLower);
    }).toList();
  }

  void _onCategoryChanged(String? category) {
    if (category != null) {
      setState(() {
        _selectedCategory = category;
        _loadMovies();
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredMovies = _filterMovies(_movies, query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Películas'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar películas...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          // Dropdown or Buttons for categories
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedCategory,
              onChanged: _onCategoryChanged,
              items: const [
                DropdownMenuItem(value: 'Popular', child: Text('Popular')),
                DropdownMenuItem(value: 'Trending', child: Text('Trending')),
                DropdownMenuItem(value: 'Now Playing', child: Text('Now Playing')),
                // Add other categories here
              ],
            ),
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_filteredMovies.isEmpty)
            const Center(child: Text('No results found.'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: _filteredMovies.length,
                itemBuilder: (context, index) {
                  final movie = _filteredMovies[index];
                  return ListTile(
                    leading: movie.posterPath != null
                        ? Image.network(
                      'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.movie),
                    title: Text(movie.title),
                    onTap: () {
                      // Redirige a la pantalla de detalles de la película
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
            ),
        ],
      ),
    );
  }
}

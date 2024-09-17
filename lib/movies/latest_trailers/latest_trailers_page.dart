import 'package:flutter/material.dart';
import 'package:pelisflix/models/movie.dart';
import 'package:pelisflix/services/tmdb_service.dart';
import 'package:pelisflix/widgets/movie_item.dart';

class LatestTrailersPage extends StatefulWidget {
  const LatestTrailersPage({Key? key}) : super(key: key);

  @override
  State<LatestTrailersPage> createState() => _LatestTrailersPageState();
}

class _LatestTrailersPageState extends State<LatestTrailersPage> {
  final TMDbService _tmdbService = TMDbService();
  List<Movie> _latestTrailers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLatestTrailers();
  }

  Future<void> _loadLatestTrailers() async {
    try {
      final trailers = await _tmdbService.getLatestTrailers();
      setState(() {
        _latestTrailers = trailers;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading latest trailers: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Últimos Trailers')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _latestTrailers.length,
        itemBuilder: (context, index) {
          final movie = _latestTrailers[index];
          return MovieItem(movie: movie, onTap: () {
            Navigator.pushNamed(context, '/movieDetail', arguments: movie);
          });
        },
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pelisflix/models/tv_series.dart';
import '../models/movie.dart';

class TMDbService {
  static const String apiKey = '8dd71474b8491ef67bf519cc4f981cea';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> getTrendingMovies() async {
    return _getMovies('$baseUrl/trending/movie/day?api_key=$apiKey');
  }

  Future<List<Movie>> getPopularMovies() async {
    return _getMovies('$baseUrl/movie/popular?api_key=$apiKey');
  }

  Future<List<TVSeries>> getPopularSeries() async {
    final response = await http.get(Uri.parse('$baseUrl/tv/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((series) => TVSeries.fromJson(series))
          .toList();
    } else {
      throw Exception('Failed to load popular series');
    }
  }

  Future<List<Movie>> _getMovies(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
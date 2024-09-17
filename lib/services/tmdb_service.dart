import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pelisflix/models/person.dart';
import 'package:pelisflix/models/tv_series.dart';
import '../models/movie.dart';

class TMDbService {
  static const String apiKey = '8dd71474b8491ef67bf519cc4f981cea';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  //funcion para devolver peliculas en tendencia
  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }


  Future<List<Movie>> getPopularMovies() async {
    return _getMovies('$baseUrl/movie/popular?api_key=$apiKey');
  }
//funcion para traer series
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

  //funcion para devolverr los ultimos trailers
  Future<List<Movie>> getLatestTrailers() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load latest trailers');
    }
  }
//funcion para devolver a los actores
  Future<List<Person>> getPopularActors() async {
    final response = await http.get(Uri.parse('$baseUrl/person/popular?api_key=$apiKey&language=en-US'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Person> actors = (data['results'] as List)
          .map((json) => Person.fromJson(json))
          .toList();
      return actors;
    } else {
      throw Exception('Failed to load popular actors');
    }
  }

  //funcion para los detalles de las peliculas
  Future<Movie> getMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  //funcion para traer el elenco de la peliculas
  Future<List<Person>> getMovieCast(int movieId) async {
    final response = await http.get(Uri.parse('$baseUrl/movie/$movieId/casts?api_key=$apiKey&language=en-US'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Person> cast = (data['cast'] as List)
          .map((json) => Person.fromJson(json))
          .toList();
      return cast;
    } else {
      throw Exception('Failed to load movie cast');
    }
  }


  //funcion para traer los trailer de las peliculas

  Future<String?> getMovieTrailer(int movieId) async {
    final response = await http.get(Uri.parse('$baseUrl/movie/$movieId/videos?api_key=$apiKey&language=en-US'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      if (results.isNotEmpty) {
        // Devuelve la clave del primer video, que generalmente es el trailer
        return results[0]['key'] as String;
      }
      return null; // No hay trailer disponible
    } else {
      throw Exception('Failed to load movie trailer');
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

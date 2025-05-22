import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelisflix/services/tmdb_service.dart';
import 'package:pelisflix/models/movie.dart';
import 'package:pelisflix/models/trailer.dart';
import 'package:pelisflix/models/actor.dart';
import 'package:pelisflix/models/person.dart'; // Added for Person model

final tmdbServiceProvider = Provider<TMDbService>((ref) {
  return TMDbService();
});

final trendingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final tmdbService = ref.watch(tmdbServiceProvider);
  return tmdbService.getTrendingMovies();
});

final latestTrailersProvider = FutureProvider<List<Trailer>>((ref) async {
  final tmdbService = ref.watch(tmdbServiceProvider);
  return tmdbService.getLatestTrailers();
});

final popularActorsProvider = FutureProvider<List<Actor>>((ref) async {
  final tmdbService = ref.watch(tmdbServiceProvider);
  return tmdbService.getPopularActors();
});

// Provider to fetch movie details by ID
final movieDetailsProvider = FutureProvider.family<Movie, int>((ref, movieId) async {
  final tmdbService = ref.watch(tmdbServiceProvider);
  return tmdbService.getMovieDetails(movieId);
});

// Provider to fetch movie cast by ID
final movieCastProvider = FutureProvider.family<List<Person>, int>((ref, movieId) async {
  final tmdbService = ref.watch(tmdbServiceProvider);
  return tmdbService.getMovieCast(movieId);
});

// Provider to fetch movie trailer key by ID
final movieTrailerProvider = FutureProvider.family<String?, int>((ref, movieId) async {
  final tmdbService = ref.watch(tmdbServiceProvider);
  return tmdbService.getMovieTrailerKey(movieId);
});

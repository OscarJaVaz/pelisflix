import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pelisflix/actors/actor_detail_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Added
import '../models/movie.dart';
import '../models/person.dart';
import '../services/tmdb_providers.dart'; // Added

class MovieDetailScreen extends ConsumerWidget { // Changed to ConsumerWidget
  final Movie movie; // Initial movie object, passed via constructor

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  // Dialog methods can remain, ensure they use context if needed from build method or passed as param
  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context, // Passed from build method
      builder: (BuildContext dialogContext) { // Use a different context name to avoid conflict
        return AlertDialog(
          title: const Text('Give your Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Rate this movie:'),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Write your comments',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _showThanksDialog(context); // Pass the main context
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _showThanksDialog(BuildContext context) { // Pass context
    showDialog(
      context: context, // Passed from build method or _showFeedbackDialog
      builder: (BuildContext dialogContext) { // Use a different context name
        return AlertDialog(
          title: const Text('Perfect!'),
          content: const Text('Thanks for your review.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Added WidgetRef ref
    // Use the initial movie's title for AppBar, details will be fetched by provider
    final movieDetailsAsync = ref.watch(movieDetailsProvider(movie.id));
    final movieCastAsync = ref.watch(movieCastProvider(movie.id));
    final movieTrailerAsync = ref.watch(movieTrailerProvider(movie.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title), // Use initial movie title
        backgroundColor: Colors.red,
      ),
      body: movieDetailsAsync.when(
        data: (fetchedMovie) { // This is the detailed movie object
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                movieTrailerAsync.when(
                  data: (trailerKey) {
                    if (trailerKey != null && trailerKey.isNotEmpty) {
                      return YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: trailerKey,
                          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
                        ),
                        showVideoProgressIndicator: true,
                      );
                    } else {
                      return Container( // Placeholder if no trailer
                        height: 200,
                        color: Colors.black,
                        child: const Center(child: Text('No trailer available.', style: TextStyle(color: Colors.white))),
                      );
                    }
                  },
                  loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
                  error: (err, stack) => SizedBox(height: 200, child: Center(child: Text('Error loading trailer: $err'))),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    fetchedMovie.title, // Use title from fetched detailed movie
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    fetchedMovie.overview, // Use overview from fetched detailed movie
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Cast:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                movieCastAsync.when(
                  data: (cast) {
                    if (cast.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text('No cast information available.'),
                      );
                    }
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cast.length,
                        itemBuilder: (context, index) {
                          final person = cast[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ActorDetailScreen(actorId: person.id),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0, right: 8.0), // Added left padding for first item
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: 'https://image.tmdb.org/t/p/w500${person.profilePath}',
                                      width: 100,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        width: 100, height: 150, color: Colors.grey[300],
                                        child: const Center(child: CircularProgressIndicator()),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        width: 100, height: 150, color: Colors.grey[300],
                                        child: const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      person.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error loading cast: $err')),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => _showFeedbackDialog(context), // Pass context
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Give Your Feedback',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading movie details: $err')),
      ),
    );
  }
}

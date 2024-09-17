import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/tmdb_service.dart';
import 'actor_detail_screen.dart'; // Importamos la nueva pantalla de detalles del actor

class PopularActorsGrid extends StatefulWidget {
  const PopularActorsGrid({Key? key}) : super(key: key);

  @override
  State<PopularActorsGrid> createState() => _PopularActorsGridState();
}

class _PopularActorsGridState extends State<PopularActorsGrid> {
  final TMDbService _tmdbService = TMDbService();
  List<Person> _popularActors = [];

  @override
  void initState() {
    super.initState();
    _loadPopularActors();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actores Populares'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: _popularActors.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: _popularActors.length,
          itemBuilder: (context, index) {
            final actor = _popularActors[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActorDetailScreen(actorId: actor.id),
                  ),
                );
              },
              child: GridTile(
                child: Column(
                  children: [
                    Expanded(
                      child: actor.profilePath != null
                          ? Image.network(
                        'https://image.tmdb.org/t/p/w200${actor.profilePath}',
                        fit: BoxFit.cover,
                      )
                          : Container(color: Colors.grey[200]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        actor.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/tmdb_service.dart';

class ActorDetailScreen extends StatefulWidget {
  final int actorId;

  const ActorDetailScreen({Key? key, required this.actorId}) : super(key: key);

  @override
  _ActorDetailScreenState createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen> {
  final TMDbService _tmdbService = TMDbService();
  late Future<Person> _actorDetails;
  late Future<List<String>> _recognizedFor;

  @override
  void initState() {
    super.initState();
    _actorDetails = _tmdbService.getPersonDetails(widget.actorId);
    _recognizedFor = _tmdbService.getPersonKnownFor(widget.actorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Actor'),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<Person>(
        future: _actorDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final actor = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  actor.profilePath != null
                      ? Image.network(
                    'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 400,
                  )
                      : Container(
                    width: double.infinity,
                    height: 400,
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      actor.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      actor.biography ?? 'No biography available',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Recognized For:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FutureBuilder<List<String>>(
                    future: _recognizedFor,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final recognizedFor = snapshot.data!;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recognizedFor.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w200${recognizedFor[index]}',
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: Text('No known for data available.'));
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}

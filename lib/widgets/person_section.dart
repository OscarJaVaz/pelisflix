import 'package:flutter/material.dart';
import '../models/person.dart';

class PersonSection extends StatelessWidget {
  final String title;
  final List<Person> actors;

  const PersonSection({
    Key? key,
    required this.title,
    required this.actors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: actors.length,
              itemBuilder: (context, index) {
                final actor = actors[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      actor.profilePath.isNotEmpty
                          ? Image.network(
                        'https://image.tmdb.org/t/p/w200${actor.profilePath}',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : const Placeholder(fallbackWidth: 100, fallbackHeight: 100),
                      Text(actor.name, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Person {
  final int id;
  final String name;
  final String profilePath;

  Person({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '', // Manejo de posibles valores nulos
    );
  }
}
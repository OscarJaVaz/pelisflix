class TVSeries {
  final int id;
  final String name;
  final String posterPath;
  final double voteAverage;

  TVSeries({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.voteAverage,
  });

  factory TVSeries.fromJson(Map<String, dynamic> json) {
    return TVSeries(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
}
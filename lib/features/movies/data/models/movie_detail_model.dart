class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final int runtime;
  final List<String> genres;
  final double voteAverage;
  final int voteCount;
  final String status;
  final List<String> productionCompanies;
  final String homepage;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
    required this.voteAverage,
    required this.voteCount,
    required this.status,
    required this.productionCompanies,
    required this.homepage,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map<String>((genre) => genre['name'] as String)
              .toList() ??
          [],
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      status: json['status'] ?? '',
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map<String>((company) => company['name'] as String)
              .toList() ??
          [],
      homepage: json['homepage'] ?? '',
    );
  }
}
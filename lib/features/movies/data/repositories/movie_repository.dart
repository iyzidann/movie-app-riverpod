import 'package:movie_app_riverpod/features/movies/data/data_providers/movie_api_service.dart';
import 'package:movie_app_riverpod/features/movies/data/models/movie_model.dart';

class MovieRepository {
  final MovieApiService apiService;
  MovieRepository(this.apiService);

  Future<List<Movie>> getPopularMovies() async {
    final results = await apiService.fetchPopularMovies();
    return results.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}
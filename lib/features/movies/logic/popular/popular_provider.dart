import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/features/movies/data/data_providers/movie_api_service.dart';
import 'package:movie_app_riverpod/features/movies/data/models/movie_model.dart';
import 'package:movie_app_riverpod/features/movies/data/repositories/movie_repository.dart';

final movieApiServiceProvider = Provider<MovieApiService>((ref) {
  return MovieApiService();
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository(ref.read(movieApiServiceProvider));
});

final popularMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.read(movieRepositoryProvider).getPopularMovies();
});

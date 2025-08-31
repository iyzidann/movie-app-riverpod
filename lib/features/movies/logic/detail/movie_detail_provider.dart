import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/features/movies/data/models/movie_detail_model.dart';
import 'package:movie_app_riverpod/features/movies/logic/popular/popular_provider.dart'; // Import to reuse existing providers

final movieDetailProvider = FutureProvider.family<MovieDetail, int>((ref, movieId) async {
  return ref.read(movieRepositoryProvider).getMovieDetail(movieId);
});
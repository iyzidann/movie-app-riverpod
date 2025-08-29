import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/features/movies/logic/popular/popular_provider.dart';
import 'package:movie_app_riverpod/features/movies/presentation/widgets/movie_card.dart';

class MovieListPage extends ConsumerWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(popularMoviesProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Popular Movies",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: moviesAsync.when(
        data: (movies) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              childAspectRatio: 2 / 3,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) => MovieCard(movie: movies[index]),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.white70,
              ),
              const SizedBox(height: 16),
              const Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                err.toString(),
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    return 4; // Desktop/Tablet default
  }
}

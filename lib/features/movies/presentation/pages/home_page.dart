import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/features/movies/logic/popular/popular_provider.dart';
import 'package:movie_app_riverpod/features/movies/presentation/pages/movie_list_page.dart';
import 'package:movie_app_riverpod/features/movies/presentation/widgets/movie_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(popularMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MovieApp"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular This Week",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MovieListPage(),
                        ),
                      );
                    },
                    child: const Text("See All"),
                  ),
                ],
              ),
            ),

            // Horizontal Slider
            moviesAsync.when(
              data: (movies) => SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: movies.length > 10 ? 10 : movies.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120,
                      child: MovieCard(movie: movies[index]),
                    );
                  },
                ),
              ),
              loading: () => Container(
                height: 200,
                child: const Center(child: CircularProgressIndicator()),
              ),
              error: (err, _) => Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 32,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Failed to load movies",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

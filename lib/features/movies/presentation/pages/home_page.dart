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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "MovieApp",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular This Week",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MovieListPage(),
                        ),
                      );
                    },
                    label: const Text(
                      "See All",
                      style: TextStyle(color: Colors.redAccent),
                    ),
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
                    final movie = movies[index];
                    return Container(
                      width: 130,
                      margin: const EdgeInsets.only(right: 4),
                      child: MovieCard(movie: movie), 
                    );
                  },
                ),
              ),
              loading: () => const SizedBox(
                height: 210,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, _) => SizedBox(
                height: 210,
                child: Center(
                  child: Text(
                    "Failed to load movies",
                    style: TextStyle(color: Colors.grey[400]),
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

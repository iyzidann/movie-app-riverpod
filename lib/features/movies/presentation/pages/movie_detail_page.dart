import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/features/movies/logic/detail/movie_detail_provider.dart';
import 'package:movie_app_riverpod/features/movies/data/models/movie_detail_model.dart';

class MovieDetailPage extends ConsumerWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetailAsync = ref.watch(movieDetailProvider(movieId));

    return movieDetailAsync.when(
      data: (movie) => _buildDetail(context, movie),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        body: Center(
          child: Text("Error: $err"),
        ),
      ),
    );
  }

  Widget _buildDetail(BuildContext context, MovieDetail movie) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Header Backdrop ala Netflix
          SliverAppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            expandedHeight: 200,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Backdrop
                  if (movie.backdropPath.isNotEmpty)
                    Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                      fit: BoxFit.cover,
                    ),
                  // Gradasi ke bawah
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Konten Detail
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster + Info singkat
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Poster Path
                      if (movie.posterPath.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                            height: 160,
                          ),
                        ),
                      const SizedBox(width: 16),
                      // Judul + Rating + Runtime
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (movie.voteAverage > 0)
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${movie.voteAverage.toStringAsFixed(1)}/10",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                const SizedBox(width: 12),
                                if (movie.runtime > 0)
                                  Text(
                                    "${movie.runtime} min",
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Genres
                  if (movie.genres.isNotEmpty)
                    Text(
                      movie.genres.join(" • "),
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),

                  const SizedBox(height: 16),

                  // Overview
                  Text(
                    movie.overview.isNotEmpty
                        ? movie.overview
                        : "No description available.",
                    style: const TextStyle(color: Colors.white, height: 1.4),
                  ),

                  const SizedBox(height: 24),

                  // Release Date & Status
                  if (movie.releaseDate.isNotEmpty)
                    Text(
                      "Release Date: ${movie.releaseDate}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  if (movie.status.isNotEmpty)
                    Text(
                      "Status: ${movie.status}",
                      style: const TextStyle(color: Colors.white70),
                    ),

                  const SizedBox(height: 24),

                  // Production Companies
                  if (movie.productionCompanies.isNotEmpty) ...[
                    const Text(
                      "Production",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.productionCompanies.take(3).join(", "),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

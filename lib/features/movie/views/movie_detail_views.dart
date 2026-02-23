import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_assistx_app/features/movie/stores/movie_detail_store.dart';
import 'package:tmdb_assistx_app/features/movie/views/widgets/movie_detail_shimmer.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/stores/app_store.dart';

class MovieDetailViews extends StatefulWidget {
  final int movieId;

  const MovieDetailViews({super.key, required this.movieId});

  @override
  State<MovieDetailViews> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailViews> {
  late final MovieDetailStore detailStore;
  final appStore = locator<AppStore>();

  @override
  void initState() {
    super.initState();
    detailStore = locator<MovieDetailStore>();
    detailStore.fetchDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (detailStore.isLoading && detailStore.movieDetail == null) {
            return MovieDetailShimmer(isDarkMode: appStore.isDarkMode);
          }

          if (detailStore.errorMessage != null) {
            return Center(child: Text(detailStore.errorMessage!));
          }

          final movie = detailStore.movieDetail;
          if (movie == null) return const SizedBox();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: movie['backdrop_path'] != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                          fit: BoxFit.cover,
                        )
                      : Container(color: Colors.grey),
                ),
                actions: [
                  Observer(
                    builder: (_) {
                      final isBookmarked = appStore.isBookmarked(movie['id']);
                      return IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked ? Colors.red : Colors.white,
                          ),
                        ),
                        onPressed: () => appStore.toggleBookmark(movie),
                      );
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie['title'] ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text('${movie['vote_average']} / 10'),
                          const SizedBox(width: 16),
                          Text('Rilis: ${movie['release_date']}'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: (movie['genres'] as List<dynamic>? ?? []).map(
                          (g) {
                            return Chip(label: Text(g['name']));
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        appStore.t['overview'] ?? 'Sinopsis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie['overview'] != null && movie['overview'] != ''
                            ? movie['overview']
                            : appStore.t['overview_not_found'] ??
                                  'Tidak ada sinopsis.',
                        style: const TextStyle(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

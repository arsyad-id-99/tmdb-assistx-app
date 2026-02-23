import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_assistx_app/core/utils/snackbar_utils.dart';
import 'package:tmdb_assistx_app/features/movie/views/movie_detail_views.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/stores/app_store.dart';

class MovieGridCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieGridCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final appStore = locator<AppStore>();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MovieDetailViews(movieId: movie['id']),
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  movie['poster_path'] != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w300${movie['poster_path']}',
                          fit: BoxFit.cover,
                        )
                      : const Center(child: Icon(Icons.movie, size: 50)),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Observer(
                      builder: (_) {
                        final isBookmarked = appStore.isBookmarked(movie['id']);
                        return CircleAvatar(
                          backgroundColor: Colors.black54,
                          radius: 18,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: isBookmarked ? Colors.red : Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              final isAdded = appStore.toggleBookmark(movie);
                              final message = isAdded
                                  ? appStore.t['bookmark_added']!
                                  : appStore.t['bookmark_removed']!;

                              SnackbarUtils.showBookmarkSnackbar(
                                context,
                                isAdded,
                                message,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title'] ?? 'Unknown',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${movie['vote_average'] ?? 0.0}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_assistx_app/core/utils/snackbar_utils.dart';
import '../../../core/di/locator.dart';
import '../../../core/stores/app_store.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    final appStore = locator<AppStore>();

    return Observer(
      builder: (_) {
        if (appStore.bookmarkedMovies.isEmpty) {
          return Center(
            child: Text(
              appStore.t['movies_not_found'] ?? 'No bookmarked movies found.',
            ),
          );
        }

        return ListView.builder(
          itemCount: appStore.bookmarkedMovies.length,
          itemBuilder: (context, index) {
            final movie = appStore.bookmarkedMovies[index];
            return ListTile(
              leading: movie['poster_path'] != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                    )
                  : const Icon(Icons.movie),
              title: Text(movie['title'] ?? 'Unknown'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  final isAdded = appStore.toggleBookmark(movie);
                  final message = isAdded
                      ? appStore.t['bookmark_added']!
                      : appStore.t['bookmark_removed']!;

                  SnackbarUtils.showBookmarkSnackbar(context, isAdded, message);
                },
              ),
            );
          },
        );
      },
    );
  }
}

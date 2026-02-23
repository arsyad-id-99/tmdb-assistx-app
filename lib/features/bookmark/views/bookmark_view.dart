import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
          return const Center(child: Text('Belum ada film yang disimpan.'));
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
                onPressed: () => appStore.toggleBookmark(movie),
              ),
            );
          },
        );
      },
    );
  }
}

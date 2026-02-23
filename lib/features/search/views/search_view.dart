import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_assistx_app/features/movie/views/widgets/movie_grid_card.dart';
import 'package:tmdb_assistx_app/features/movie/views/widgets/movie_grid_shimmer.dart';
import '../../../core/di/locator.dart';
import '../../../core/stores/app_store.dart';
import '../stores/search_store.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final SearchStore searchStore;
  final appStore = locator<AppStore>();

  @override
  void initState() {
    super.initState();
    searchStore = locator<SearchStore>();
  }

  @override
  void dispose() {
    searchStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: searchStore.onSearchInput,
          decoration: InputDecoration(
            hintText: appStore.t['search'],
            border: InputBorder.none,
          ),
        ),
      ),
      body: Observer(
        builder: (_) {
          if (searchStore.isLoading) {
            return MovieGridShimmer(isDarkMode: appStore.isDarkMode);
          }

          if (searchStore.currentQuery.isEmpty) {
            return const Center(
              child: Icon(Icons.search, size: 80, color: Colors.grey),
            );
          }

          if (searchStore.searchResults.isEmpty) {
            return const Center(child: Text('Film tidak ditemukan.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: searchStore.searchResults.length,
            itemBuilder: (context, index) {
              return MovieGridCard(movie: searchStore.searchResults[index]);
            },
          );
        },
      ),
    );
  }
}

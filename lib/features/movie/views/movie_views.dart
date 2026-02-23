import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_assistx_app/features/movie/stores/movie_store.dart';
import 'package:tmdb_assistx_app/features/movie/views/widgets/movie_grid_card.dart';
import 'package:tmdb_assistx_app/features/movie/views/widgets/movie_grid_shimmer.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/stores/app_store.dart';

class MovieViews extends StatefulWidget {
  const MovieViews({super.key});

  @override
  State<MovieViews> createState() => _MovieViewsState();
}

class _MovieViewsState extends State<MovieViews> {
  final MovieStore movieStore = locator<MovieStore>();
  final AppStore appStore = locator<AppStore>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (movieStore.movies.isEmpty) movieStore.fetchMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        movieStore.fetchMovies();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Observer(
            builder: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Urutkan Berdasarkan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildSortTile(
                  appStore.t['most_popular']!,
                  'popularity.desc',
                  Icons.trending_up,
                ),
                _buildSortTile(
                  appStore.t['highest_rated']!,
                  'vote_average.desc',
                  Icons.star,
                ),
                _buildSortTile(
                  appStore.t['latest_release']!,
                  'primary_release_date.desc',
                  Icons.calendar_today,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSortTile(String title, String sortValue, IconData icon) {
    final isActive = movieStore.sortBy == sortValue;
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.blue : null),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isActive
          ? const Icon(Icons.check_circle, color: Colors.blue)
          : null,
      selected: isActive,
      onTap: () {
        movieStore.changeSortBy(sortValue);
        Navigator.pop(context);
      },
    );
  }

  void _showFilterBottomSheet() {
    movieStore.fetchGenres();

    int? tempGenreId = movieStore.selectedGenreId;
    TextEditingController yearController = TextEditingController(
      text: movieStore.selectedYear ?? '',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appStore.t['filter']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    appStore.t['genre']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Observer(
                    builder: (_) {
                      if (movieStore.genres.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Wrap(
                        spacing: 8,
                        children: movieStore.genres.map((genre) {
                          final isSelected = tempGenreId == genre['id'];
                          return ChoiceChip(
                            label: Text(genre['name']),
                            selected: isSelected,
                            selectedColor: Colors.blue.withValues(alpha: .3),
                            onSelected: (selected) {
                              setModalState(() {
                                tempGenreId = selected ? genre['id'] : null;
                              });
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  Text(
                    appStore.t['release_year']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: yearController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(
                      hintText: '2026',
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            movieStore.applyFilter(genreId: null, year: null);
                            Navigator.pop(context);
                          },
                          child: Text(appStore.t['reset']!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            movieStore.applyFilter(
                              genreId: tempGenreId,
                              year: yearController.text.trim().isEmpty
                                  ? null
                                  : yearController.text.trim(),
                            );
                            Navigator.pop(context);
                          },
                          child: Text(appStore.t['apply']!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.sort),
                      label: Text(appStore.t['sort']!),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _showSortBottomSheet,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.filter_list),
                      label: Text(appStore.t['filter']!),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _showFilterBottomSheet,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: Observer(
            builder: (_) {
              if (movieStore.movies.isEmpty && movieStore.isLoading) {
                return MovieGridShimmer(isDarkMode: appStore.isDarkMode);
              }

              if (movieStore.movies.isEmpty) {
                return const Center(child: Text('Tidak ada film ditemukan.'));
              }

              return GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount:
                    movieStore.movies.length + (movieStore.isLoading ? 2 : 0),
                itemBuilder: (context, index) {
                  if (index >= movieStore.movies.length) {
                    return MovieGridShimmer(isDarkMode: appStore.isDarkMode);
                  }

                  final movie = movieStore.movies[index];
                  return MovieGridCard(movie: movie);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

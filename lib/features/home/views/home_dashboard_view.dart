import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_assistx_app/core/stores/app_store.dart';
import 'package:tmdb_assistx_app/features/home/views/widgets/home_dashboard_shimmer.dart';
import 'package:tmdb_assistx_app/features/movie/views/movie_detail_views.dart';
import '../../../core/di/locator.dart';
import '../stores/home_store.dart';

class HomeDashboardView extends StatefulWidget {
  const HomeDashboardView({super.key});

  @override
  State<HomeDashboardView> createState() => _HomeDashboardViewState();
}

class _HomeDashboardViewState extends State<HomeDashboardView> {
  final HomeStore homeStore = locator<HomeStore>();
  final appStore = locator<AppStore>();

  @override
  void initState() {
    super.initState();
    if (homeStore.nowPlayingMovies.isEmpty) {
      homeStore.fetchHomeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final isInitialLoading =
            homeStore.isLoading && homeStore.nowPlayingMovies.isEmpty;
        final isDarkMode = appStore.isDarkMode;

        return RefreshIndicator(
          onRefresh: homeStore.fetchHomeData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    appStore.t['now_playing'] ?? 'Now Playing',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                isInitialLoading
                    ? CarouselShimmer(isDarkMode: isDarkMode)
                    : _buildCarousel(homeStore.nowPlayingMovies),

                const SizedBox(height: 24),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    appStore.t['popular'] ?? 'Popular',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                isInitialLoading
                    ? HorizontalListShimmer(isDarkMode: isDarkMode)
                    : _buildHorizontalList(homeStore.popularMovies),

                const SizedBox(height: 24),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    appStore.t['upcoming'] ?? 'Upcoming',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                isInitialLoading
                    ? HorizontalListShimmer(isDarkMode: isDarkMode)
                    : _buildHorizontalList(homeStore.upcomingMovies),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarousel(List<dynamic> movies) {
    if (movies.isEmpty) return const SizedBox();
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${movie['backdrop_path'] ?? movie['poster_path']}',
                ),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: .8),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Text(
                movie['title'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalList(List<dynamic> movies) {
    if (movies.isEmpty) return const SizedBox();
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailViews(movieId: movie['id']),
                ),
              );
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, obj, stackTrace) =>
                            Container(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie['title'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

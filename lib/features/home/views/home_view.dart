import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb_assistx_app/features/bookmark/views/bookmark_view.dart';
import 'package:tmdb_assistx_app/features/home/views/home_dashboard_view.dart';
import 'package:tmdb_assistx_app/features/movie/views/movie_views.dart';
import 'package:tmdb_assistx_app/features/search/views/search_view.dart';
import 'package:tmdb_assistx_app/features/settings/views/setting_view.dart';
import '../../../core/di/locator.dart';
import '../../../core/stores/app_store.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final appStore = locator<AppStore>();

  final List<Widget> _pages = [
    const HomeDashboardView(),
    const MovieViews(),
    const BookmarkView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) => Text(_getTitle())),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchView()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Observer(
        builder: (_) => BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: appStore.t['home'],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.movie),
              label: appStore.t['discover'],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bookmark),
              label: appStore.t['bookmarked'],
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return appStore.t['home']!;
      case 1:
        return appStore.t['discover']!;
      case 2:
        return appStore.t['bookmarked']!;
      default:
        return 'App';
    }
  }
}

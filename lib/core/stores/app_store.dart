import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  final SharedPreferences _prefs;

  _AppStore(this._prefs) {
    _loadBookmarks();
    _loadThemeAndLanguage();
  }

  @observable
  bool isDarkMode = true;

  @observable
  String locale = 'id';

  @observable
  ObservableList<Map<String, dynamic>> bookmarkedMovies =
      ObservableList<Map<String, dynamic>>();

  @computed
  Map<String, String> get t {
    if (locale == 'ja') {
      return {
        'movies': '映画',
        'bookmarked': 'ブックマーク',
        'search': '映画を検索...',
        'settings': '設定',
        'theme': 'テーマ',
        'language': '言語',
        'discover': '発見',
        'home': 'ホーム',
        'now_playing': '上映中',
        'popular': '人気',
        'upcoming': '近日公開',
        'sort': '並び替え',
        'sort_by': '並び順',
        'most_popular': '人気順',
        'highest_rated': '評価順',
        'latest_release': '最新リリース',
        'filter': 'フィルター',
        'release_year': '公開年',
        'genre': 'ジャンル',
        'reset': 'リセット',
        'apply': '適用',
        'overview_not_found': '概要が見つかりませんでした。',
        'overview': '概要',
      };
    } else if (locale == 'en') {
      return {
        'movies': 'Movies',
        'bookmarked': 'Bookmarked',
        'search': 'Search movies...',
        'settings': 'Settings',
        'theme': 'Theme',
        'language': 'Language',
        'discover': 'Discover',
        'home': 'Home',
        'now_playing': 'Now Playing',
        'popular': 'Popular',
        'upcoming': 'Upcoming',
        'sort': 'Sort',
        'sort_by': 'Sort By',
        'most_popular': 'Most Popular',
        'highest_rated': 'Highest Rated',
        'latest_release': 'Latest Release',
        'filter': 'Filter',
        'release_year': 'Release Year',
        'genre': 'Genre',
        'reset': 'Reset',
        'apply': 'Apply',
        'overview_not_found': 'Overview not found.',
        'overview': 'Overview',
      };
    }
    // Default: ID
    return {
      'movies': 'Film',
      'bookmarked': 'Tersimpan',
      'search': 'Cari film...',
      'settings': 'Pengaturan',
      'theme': 'Tema',
      'language': 'Bahasa',
      'discover': 'Temukan',
      'home': 'Beranda',
      'now_playing': 'Sedang Tayang',
      'popular': 'Populer',
      'upcoming': 'Akan Datang',
      'sort': 'Urutkan',
      'sort_by': 'Urutkan Berdasarkan',
      'most_popular': 'Paling Populer',
      'highest_rated': 'Rating Tertinggi',
      'latest_release': 'Rilis Terbaru',
      'filter': 'Filter',
      'release_year': 'Tahun Rilis',
      'genre': 'Genre',
      'reset': 'Reset',
      'apply': 'Terapkan',
      'overview_not_found': 'Ringkasan tidak ditemukan.',
      'overview': 'Sinopsis',
    };
  }

  @action
  void _loadBookmarks() {
    final String? bookmarksString = _prefs.getString('bookmarked_movies');
    if (bookmarksString != null) {
      final List<dynamic> decodedList = jsonDecode(bookmarksString);
      bookmarkedMovies.addAll(decodedList.cast<Map<String, dynamic>>());
    }
  }

  void _saveBookmarksToPrefs() {
    final String encodedString = jsonEncode(bookmarkedMovies);
    _prefs.setString('bookmarked_movies', encodedString);
  }

  @action
  void toggleBookmark(Map<String, dynamic> movie) {
    final isExist = bookmarkedMovies.any((m) => m['id'] == movie['id']);
    if (isExist) {
      bookmarkedMovies.removeWhere((m) => m['id'] == movie['id']);
    } else {
      bookmarkedMovies.add(movie);
    }

    _saveBookmarksToPrefs();
  }

  bool isBookmarked(int movieId) {
    return bookmarkedMovies.any((m) => m['id'] == movieId);
  }

  @action
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    _prefs.setBool('is_dark_mode', isDarkMode);
  }

  @action
  void toggleLanguage() {
    locale = locale == 'id' ? 'en' : 'id';
    _prefs.setString('locale', locale);
  }

  @action
  void _loadThemeAndLanguage() {
    isDarkMode = _prefs.getBool('is_dark_mode') ?? true;
    locale = _prefs.getString('locale') ?? 'id';
  }

  @action
  void setTheme(bool isDark) {
    isDarkMode = isDark;
    _prefs.setBool('is_dark_mode', isDarkMode);
  }

  @action
  void setLanguage(String newLocale) {
    locale = newLocale;
    _prefs.setString('locale', locale);
  }
}

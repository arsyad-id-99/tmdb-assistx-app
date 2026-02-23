import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import '../services/movie_service.dart';
import '../../../../core/stores/app_store.dart';

part 'movie_store.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  final MovieService _service;
  final AppStore _appStore;

  _MovieStore(this._service, this._appStore);

  @observable
  ObservableList<dynamic> movies = ObservableList<dynamic>();

  @observable
  bool isLoading = false;

  @observable
  int currentPage = 1;

  @observable
  String sortBy = 'popularity.desc';

  @observable
  ObservableList<dynamic> genres = ObservableList<dynamic>();

  @observable
  int? selectedGenreId;

  @observable
  String? selectedYear;

  @action
  Future<void> fetchGenres() async {
    if (genres.isNotEmpty) return;
    try {
      final lang = _appStore.locale;
      final fetchedGenres = await _service.fetchGenres(lang);
      genres.clear();
      genres.addAll(fetchedGenres);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching genres: $e");
      }
    }
  }

  @action
  void applyFilter({int? genreId, String? year}) {
    selectedGenreId = genreId;
    selectedYear = year;
    currentPage = 1;
    movies.clear();
    fetchMovies();
  }

  @action
  void changeSortBy(String newSort) {
    sortBy = newSort;
    currentPage = 1;
    movies.clear();
    fetchMovies();
  }

  @action
  Future<void> fetchMovies({bool isRefresh = false}) async {
    if (isLoading) return;
    isLoading = true;

    if (isRefresh) {
      movies.clear();
      genres.clear();
      currentPage = 1;
    }

    try {
      final lang = _appStore.locale;
      final newMovies = await _service.fetchDiscover(
        currentPage,
        sortBy,
        lang,
        genreId: selectedGenreId,
        year: selectedYear,
      );

      movies.addAll(newMovies);
      currentPage++;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
    }
  }
}

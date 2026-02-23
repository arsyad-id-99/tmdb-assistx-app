import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:tmdb_assistx_app/core/stores/app_store.dart';
import '../../movie/services/movie_service.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final MovieService _service;
  final AppStore _appStore;

  _HomeStore(this._service, this._appStore);

  @observable
  ObservableList<dynamic> nowPlayingMovies = ObservableList<dynamic>();

  @observable
  ObservableList<dynamic> popularMovies = ObservableList<dynamic>();

  @observable
  ObservableList<dynamic> upcomingMovies = ObservableList<dynamic>();

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchHomeData({bool isRefresh = false}) async {
    if (isLoading) return;
    isLoading = true;

    if (isRefresh) {
      nowPlayingMovies.clear();
      popularMovies.clear();
      upcomingMovies.clear();
    }
    try {
      final lang = _appStore.locale;
      final results = await Future.wait([
        _service.fetchNowPlaying(lang),
        _service.fetchPopular(lang),
        _service.fetchUpcoming(lang),
      ]);

      nowPlayingMovies.clear();
      nowPlayingMovies.addAll(results[0]);

      popularMovies.clear();
      popularMovies.addAll(results[1]);

      upcomingMovies.clear();
      upcomingMovies.addAll(results[2]);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching home data: $e");
      }
    } finally {
      isLoading = false;
    }
  }
}

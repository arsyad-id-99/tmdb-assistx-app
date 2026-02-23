import 'package:mobx/mobx.dart';
import 'package:tmdb_assistx_app/core/stores/app_store.dart';
import '../services/movie_service.dart';

part 'movie_detail_store.g.dart';

class MovieDetailStore = _MovieDetailStore with _$MovieDetailStore;

abstract class _MovieDetailStore with Store {
  final MovieService _service;
  final AppStore _appStore;

  _MovieDetailStore(this._service, this._appStore);

  @observable
  bool isLoading = false;

  @observable
  Map<String, dynamic>? movieDetail;

  @observable
  String? errorMessage;

  @action
  Future<void> fetchDetail(int movieId) async {
    isLoading = true;
    errorMessage = null;

    try {
      final lang = _appStore.locale;
      movieDetail = await _service.fetchMovieDetails(movieId, lang);
    } catch (e) {
      errorMessage = "Gagal memuat detail film.";
    } finally {
      isLoading = false;
    }
  }
}

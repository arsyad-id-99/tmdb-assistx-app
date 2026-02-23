import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdb_assistx_app/features/movie/services/movie_service.dart';
import '../../../../core/stores/app_store.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  final MovieService _service;
  final AppStore _appStore;
  final _searchSubject = PublishSubject<String>();

  _SearchStore(this._service, this._appStore) {
    _searchSubject
        .debounceTime(const Duration(milliseconds: 800))
        .distinct()
        .listen((query) => _onSearchTriggered(query));
  }

  @observable
  ObservableList<dynamic> searchResults = ObservableList<dynamic>();

  @observable
  bool isLoading = false;

  @observable
  String currentQuery = '';

  @action
  void onSearchInput(String query) {
    if (query.trim().isEmpty) {
      searchResults.clear();
      currentQuery = '';
      return;
    }
    _searchSubject.add(query);
  }

  @action
  Future<void> _onSearchTriggered(String query) async {
    currentQuery = query;
    isLoading = true;
    searchResults.clear();

    try {
      final lang = _appStore.locale;
      final results = await _service.fetchSearch(1, query, lang);
      searchResults.addAll(results);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
    }
  }

  @action
  void dispose() {
    _searchSubject.close();
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieStore on _MovieStore, Store {
  late final _$moviesAtom = Atom(name: '_MovieStore.movies', context: context);

  @override
  ObservableList<dynamic> get movies {
    _$moviesAtom.reportRead();
    return super.movies;
  }

  @override
  set movies(ObservableList<dynamic> value) {
    _$moviesAtom.reportWrite(value, super.movies, () {
      super.movies = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_MovieStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$currentPageAtom = Atom(
    name: '_MovieStore.currentPage',
    context: context,
  );

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$sortByAtom = Atom(name: '_MovieStore.sortBy', context: context);

  @override
  String get sortBy {
    _$sortByAtom.reportRead();
    return super.sortBy;
  }

  @override
  set sortBy(String value) {
    _$sortByAtom.reportWrite(value, super.sortBy, () {
      super.sortBy = value;
    });
  }

  late final _$genresAtom = Atom(name: '_MovieStore.genres', context: context);

  @override
  ObservableList<dynamic> get genres {
    _$genresAtom.reportRead();
    return super.genres;
  }

  @override
  set genres(ObservableList<dynamic> value) {
    _$genresAtom.reportWrite(value, super.genres, () {
      super.genres = value;
    });
  }

  late final _$selectedGenreIdAtom = Atom(
    name: '_MovieStore.selectedGenreId',
    context: context,
  );

  @override
  int? get selectedGenreId {
    _$selectedGenreIdAtom.reportRead();
    return super.selectedGenreId;
  }

  @override
  set selectedGenreId(int? value) {
    _$selectedGenreIdAtom.reportWrite(value, super.selectedGenreId, () {
      super.selectedGenreId = value;
    });
  }

  late final _$selectedYearAtom = Atom(
    name: '_MovieStore.selectedYear',
    context: context,
  );

  @override
  String? get selectedYear {
    _$selectedYearAtom.reportRead();
    return super.selectedYear;
  }

  @override
  set selectedYear(String? value) {
    _$selectedYearAtom.reportWrite(value, super.selectedYear, () {
      super.selectedYear = value;
    });
  }

  late final _$fetchGenresAsyncAction = AsyncAction(
    '_MovieStore.fetchGenres',
    context: context,
  );

  @override
  Future<void> fetchGenres() {
    return _$fetchGenresAsyncAction.run(() => super.fetchGenres());
  }

  late final _$fetchMoviesAsyncAction = AsyncAction(
    '_MovieStore.fetchMovies',
    context: context,
  );

  @override
  Future<void> fetchMovies({bool isRefresh = false}) {
    return _$fetchMoviesAsyncAction.run(
      () => super.fetchMovies(isRefresh: isRefresh),
    );
  }

  late final _$_MovieStoreActionController = ActionController(
    name: '_MovieStore',
    context: context,
  );

  @override
  void applyFilter({int? genreId, String? year}) {
    final _$actionInfo = _$_MovieStoreActionController.startAction(
      name: '_MovieStore.applyFilter',
    );
    try {
      return super.applyFilter(genreId: genreId, year: year);
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSortBy(String newSort) {
    final _$actionInfo = _$_MovieStoreActionController.startAction(
      name: '_MovieStore.changeSortBy',
    );
    try {
      return super.changeSortBy(newSort);
    } finally {
      _$_MovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
movies: ${movies},
isLoading: ${isLoading},
currentPage: ${currentPage},
sortBy: ${sortBy},
genres: ${genres},
selectedGenreId: ${selectedGenreId},
selectedYear: ${selectedYear}
    ''';
  }
}

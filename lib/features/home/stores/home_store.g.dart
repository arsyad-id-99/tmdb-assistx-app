// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$nowPlayingMoviesAtom = Atom(
    name: '_HomeStore.nowPlayingMovies',
    context: context,
  );

  @override
  ObservableList<dynamic> get nowPlayingMovies {
    _$nowPlayingMoviesAtom.reportRead();
    return super.nowPlayingMovies;
  }

  @override
  set nowPlayingMovies(ObservableList<dynamic> value) {
    _$nowPlayingMoviesAtom.reportWrite(value, super.nowPlayingMovies, () {
      super.nowPlayingMovies = value;
    });
  }

  late final _$popularMoviesAtom = Atom(
    name: '_HomeStore.popularMovies',
    context: context,
  );

  @override
  ObservableList<dynamic> get popularMovies {
    _$popularMoviesAtom.reportRead();
    return super.popularMovies;
  }

  @override
  set popularMovies(ObservableList<dynamic> value) {
    _$popularMoviesAtom.reportWrite(value, super.popularMovies, () {
      super.popularMovies = value;
    });
  }

  late final _$upcomingMoviesAtom = Atom(
    name: '_HomeStore.upcomingMovies',
    context: context,
  );

  @override
  ObservableList<dynamic> get upcomingMovies {
    _$upcomingMoviesAtom.reportRead();
    return super.upcomingMovies;
  }

  @override
  set upcomingMovies(ObservableList<dynamic> value) {
    _$upcomingMoviesAtom.reportWrite(value, super.upcomingMovies, () {
      super.upcomingMovies = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_HomeStore.isLoading',
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

  late final _$fetchHomeDataAsyncAction = AsyncAction(
    '_HomeStore.fetchHomeData',
    context: context,
  );

  @override
  Future<void> fetchHomeData({bool isRefresh = false}) {
    return _$fetchHomeDataAsyncAction.run(
      () => super.fetchHomeData(isRefresh: isRefresh),
    );
  }

  @override
  String toString() {
    return '''
nowPlayingMovies: ${nowPlayingMovies},
popularMovies: ${popularMovies},
upcomingMovies: ${upcomingMovies},
isLoading: ${isLoading}
    ''';
  }
}

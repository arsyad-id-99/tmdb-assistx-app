// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieDetailStore on _MovieDetailStore, Store {
  late final _$isLoadingAtom = Atom(
    name: '_MovieDetailStore.isLoading',
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

  late final _$movieDetailAtom = Atom(
    name: '_MovieDetailStore.movieDetail',
    context: context,
  );

  @override
  Map<String, dynamic>? get movieDetail {
    _$movieDetailAtom.reportRead();
    return super.movieDetail;
  }

  @override
  set movieDetail(Map<String, dynamic>? value) {
    _$movieDetailAtom.reportWrite(value, super.movieDetail, () {
      super.movieDetail = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_MovieDetailStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchDetailAsyncAction = AsyncAction(
    '_MovieDetailStore.fetchDetail',
    context: context,
  );

  @override
  Future<void> fetchDetail(int movieId) {
    return _$fetchDetailAsyncAction.run(() => super.fetchDetail(movieId));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
movieDetail: ${movieDetail},
errorMessage: ${errorMessage}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchStore on _SearchStore, Store {
  late final _$searchResultsAtom = Atom(
    name: '_SearchStore.searchResults',
    context: context,
  );

  @override
  ObservableList<dynamic> get searchResults {
    _$searchResultsAtom.reportRead();
    return super.searchResults;
  }

  @override
  set searchResults(ObservableList<dynamic> value) {
    _$searchResultsAtom.reportWrite(value, super.searchResults, () {
      super.searchResults = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_SearchStore.isLoading',
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

  late final _$currentQueryAtom = Atom(
    name: '_SearchStore.currentQuery',
    context: context,
  );

  @override
  String get currentQuery {
    _$currentQueryAtom.reportRead();
    return super.currentQuery;
  }

  @override
  set currentQuery(String value) {
    _$currentQueryAtom.reportWrite(value, super.currentQuery, () {
      super.currentQuery = value;
    });
  }

  late final _$_onSearchTriggeredAsyncAction = AsyncAction(
    '_SearchStore._onSearchTriggered',
    context: context,
  );

  @override
  Future<void> _onSearchTriggered(String query) {
    return _$_onSearchTriggeredAsyncAction.run(
      () => super._onSearchTriggered(query),
    );
  }

  late final _$_SearchStoreActionController = ActionController(
    name: '_SearchStore',
    context: context,
  );

  @override
  void onSearchInput(String query) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
      name: '_SearchStore.onSearchInput',
    );
    try {
      return super.onSearchInput(query);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
      name: '_SearchStore.dispose',
    );
    try {
      return super.dispose();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchResults: ${searchResults},
isLoading: ${isLoading},
currentQuery: ${currentQuery}
    ''';
  }
}

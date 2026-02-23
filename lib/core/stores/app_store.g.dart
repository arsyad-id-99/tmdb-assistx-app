// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  Computed<Map<String, String>>? _$tComputed;

  @override
  Map<String, String> get t => (_$tComputed ??= Computed<Map<String, String>>(
    () => super.t,
    name: '_AppStore.t',
  )).value;

  late final _$isDarkModeAtom = Atom(
    name: '_AppStore.isDarkMode',
    context: context,
  );

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$localeAtom = Atom(name: '_AppStore.locale', context: context);

  @override
  String get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(String value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$bookmarkedMoviesAtom = Atom(
    name: '_AppStore.bookmarkedMovies',
    context: context,
  );

  @override
  ObservableList<Map<String, dynamic>> get bookmarkedMovies {
    _$bookmarkedMoviesAtom.reportRead();
    return super.bookmarkedMovies;
  }

  @override
  set bookmarkedMovies(ObservableList<Map<String, dynamic>> value) {
    _$bookmarkedMoviesAtom.reportWrite(value, super.bookmarkedMovies, () {
      super.bookmarkedMovies = value;
    });
  }

  late final _$_AppStoreActionController = ActionController(
    name: '_AppStore',
    context: context,
  );

  @override
  void _loadBookmarks() {
    final _$actionInfo = _$_AppStoreActionController.startAction(
      name: '_AppStore._loadBookmarks',
    );
    try {
      return super._loadBookmarks();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool toggleBookmark(Map<String, dynamic> movie) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
      name: '_AppStore.toggleBookmark',
    );
    try {
      return super.toggleBookmark(movie);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTheme() {
    final _$actionInfo = _$_AppStoreActionController.startAction(
      name: '_AppStore.toggleTheme',
    );
    try {
      return super.toggleTheme();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleLanguage() {
    final _$actionInfo = _$_AppStoreActionController.startAction(
      name: '_AppStore.toggleLanguage',
    );
    try {
      return super.toggleLanguage();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _loadThemeAndLanguage() {
    final _$actionInfo = _$_AppStoreActionController.startAction(
      name: '_AppStore._loadThemeAndLanguage',
    );
    try {
      return super._loadThemeAndLanguage();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTheme(bool isDark) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
      name: '_AppStore.setTheme',
    );
    try {
      return super.setTheme(isDark);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLanguage(String newLocale) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
      name: '_AppStore.setLanguage',
    );
    try {
      return super.setLanguage(newLocale);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode},
locale: ${locale},
bookmarkedMovies: ${bookmarkedMovies},
t: ${t}
    ''';
  }
}

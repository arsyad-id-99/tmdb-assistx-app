import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_assistx_app/features/home/stores/home_store.dart';
import 'package:tmdb_assistx_app/features/movie/stores/movie_detail_store.dart';
import 'package:tmdb_assistx_app/features/search/stores/search_store.dart';
import '../stores/app_store.dart';
import '../../features/movie/services/movie_service.dart';
import '../../features/movie/stores/movie_store.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  locator.registerLazySingleton<AppStore>(
    () => AppStore(locator<SharedPreferences>()),
  );
  locator.registerLazySingleton<MovieService>(() => MovieService());

  locator.registerLazySingleton<HomeStore>(
    () => HomeStore(locator<MovieService>(), locator<AppStore>()),
  );
  locator.registerLazySingleton<MovieStore>(
    () => MovieStore(locator<MovieService>(), locator<AppStore>()),
  );
  locator.registerFactory<MovieDetailStore>(
    () => MovieDetailStore(locator<MovieService>(), locator<AppStore>()),
  );
  locator.registerFactory<SearchStore>(
    () => SearchStore(locator<MovieService>(), locator<AppStore>()),
  );
}

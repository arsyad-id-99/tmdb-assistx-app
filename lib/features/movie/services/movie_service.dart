import 'package:dio/dio.dart';

class MovieService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': 'API_KEY_HERE'}, // Ganti API Key
    ),
  );

  Future<List<dynamic>> fetchDiscover(
    int page,
    String sortBy,
    String language, {
    int? genreId,
    String? year,
  }) async {
    final queryParams = {'page': page, 'sort_by': sortBy, 'language': language};

    if (genreId != null) queryParams['with_genres'] = genreId;
    if (year != null && year.isNotEmpty) {
      queryParams['primary_release_year'] = year;
    }

    final response = await _dio.get(
      '/discover/movie',
      queryParameters: queryParams,
    );
    return response.data['results'];
  }

  Future<List<dynamic>> fetchSearch(
    int page,
    String query,
    String language,
  ) async {
    final response = await _dio.get(
      '/search/movie',
      queryParameters: {'page': page, 'query': query, 'language': language},
    );
    return response.data['results'];
  }

  Future<List<dynamic>> fetchNowPlaying(String language) async {
    final response = await _dio.get(
      '/movie/now_playing',
      queryParameters: {'language': language},
    );
    return response.data['results'];
  }

  Future<List<dynamic>> fetchPopular(String language) async {
    final response = await _dio.get(
      '/movie/popular',
      queryParameters: {'language': language},
    );
    return response.data['results'];
  }

  Future<List<dynamic>> fetchUpcoming(String language) async {
    final response = await _dio.get(
      '/movie/upcoming',
      queryParameters: {'language': language},
    );
    return response.data['results'];
  }

  Future<Map<String, dynamic>> fetchMovieDetails(
    int movieId,
    String language,
  ) async {
    final response = await _dio.get(
      '/movie/$movieId',
      queryParameters: {'language': language},
    );
    return response.data;
  }

  Future<List<dynamic>> fetchGenres(String language) async {
    final response = await _dio.get(
      '/genre/movie/list',
      queryParameters: {'language': language},
    );
    return response.data['genres'];
  }
}

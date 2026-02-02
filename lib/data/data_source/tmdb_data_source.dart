import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/movie_response_dto.dart';
import 'movie_data_source.dart';

class TMDBDataSource implements MovieDataSource {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYmNiNzJjNzQ4N2U1N2QxNDdiNDk3Mjg3MTlmZDE5ZiIsIm5iZiI6MTczMzM5MTMxNy45NzUwMDAxLCJzdWIiOiI2NzUxNzNkNThhZjZkM2ZlYjNhZmU0NDUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xwBAH8_W-yBA3RoH9JscnBQe_1McKgodxi1JO-kcJn8';

  final http.Client _client;

  TMDBDataSource({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> get _headers => {
    'accept': 'application/json',
    'Authorization': 'Bearer $_token',
  };

  /// 현재 상영중 (Now Playing) 영화 목록을 가져옵니다.
  Future<MovieResponseDto> getNowPlaying({int page = 1}) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/movie/now_playing?language=ko-KR&page=$page'),
      headers: _headers,
    );
    return _decodeResponse(response);
  }

  /// 인기순 (Popular) 영화 목록을 가져옵니다.
  Future<MovieResponseDto> getPopular({int page = 1}) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/movie/popular?language=ko-KR&page=$page'),
      headers: _headers,
    );
    return _decodeResponse(response);
  }

  /// 평점 높은순 (Top Rated) 영화 목록을 가져옵니다.
  Future<MovieResponseDto> getTopRated({int page = 1}) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/movie/top_rated?language=ko-KR&page=$page'),
      headers: _headers,
    );
    return _decodeResponse(response);
  }

  /// 개봉 예정 (Upcoming) 영화 목록을 가져옵니다.
  Future<MovieResponseDto> getUpcoming({int page = 1}) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/movie/upcoming?language=ko-KR&page=$page'),
      headers: _headers,
    );
    return _decodeResponse(response);
  }

  /// 영화 상세 정보 (Movie Details)를 가져옵니다.
  /// 상세 정보의 경우 목록 DTO보다 필드가 많을 수 있으므로 Map으로 반환하거나 필요 시 별도 DTO를 생성해야 합니다.
  Future<Map<String, dynamic>> getMovieDetail(int movieId) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/movie/$movieId?language=ko-KR'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load movie detail: ${response.statusCode}');
    }
  }

  MovieResponseDto _decodeResponse(http.Response response) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return MovieResponseDto.fromJson(data);
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}

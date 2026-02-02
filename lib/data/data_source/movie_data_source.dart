import 'package:flutter_movie/data/dto/movie_response_dto.dart';

abstract class MovieDataSource {
  Future<MovieResponseDto> getNowPlaying({int page = 1});
  Future<MovieResponseDto> getPopular({int page = 1});
  Future<MovieResponseDto> getTopRated({int page = 1});
  Future<MovieResponseDto> getUpcoming({int page = 1});
  Future<Map<String, dynamic>> getMovieDetail(int id);
}

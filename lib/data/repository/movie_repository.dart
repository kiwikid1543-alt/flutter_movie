import 'package:flutter_movie/data/data_source/movie_data_source.dart';

import '../../domain/entity/movie_entity.dart';
import '../dto/movie_response_dto.dart';

class MovieRepository {
  final MovieDataSource _movieDataSource;
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  MovieRepository({required MovieDataSource movieDataSource})
    : _movieDataSource = movieDataSource;

  /// 현재 상영 중인 영화 목록을 가져와 엔티티 리스트로 변환합니다.
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {
    final response = await _movieDataSource.getNowPlaying(page: page);
    return response.results.map(_toEntity).toList();
  }

  /// 인기 영화 목록을 가져와 엔티티 리스트로 변환합니다.
  Future<List<MovieEntity>> getPopular({int page = 1}) async {
    final response = await _movieDataSource.getPopular(page: page);
    return response.results.map(_toEntity).toList();
  }

  /// 평점 높은 영화 목록을 가져와 엔티티 리스트로 변환합니다.
  Future<List<MovieEntity>> getTopRated({int page = 1}) async {
    final response = await _movieDataSource.getTopRated(page: page);
    return response.results.map(_toEntity).toList();
  }

  /// 개봉 예정 영화 목록을 가져와 엔티티 리스트로 변환합니다.
  Future<List<MovieEntity>> getUpcoming({int page = 1}) async {
    final response = await _movieDataSource.getUpcoming(page: page);
    return response.results.map(_toEntity).toList();
  }

  /// 영화 상세 정보를 가져와 엔티티로 변환합니다.
  /// 엔티티는 id와 posterImageUrl만 포함하므로 추출하여 반환합니다.
  Future<MovieEntity> getMovieDetail(int id) async {
    final json = await _movieDataSource.getMovieDetail(id);
    final posterPath = json['poster_path'] as String?;

    return MovieEntity(
      id: id,
      posterImageUrl: posterPath != null ? '$_imageBaseUrl$posterPath' : '',
    );
  }

  /// MovieDto를 MovieEntity로 변환하는 유틸리티 메서드입니다.
  MovieEntity _toEntity(MovieDto dto) {
    return MovieEntity(
      id: dto.id,
      posterImageUrl: dto.posterPath != null
          ? '$_imageBaseUrl${dto.posterPath}'
          : '',
    );
  }
}

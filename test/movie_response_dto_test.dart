import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_movie/data/dto/movie_response_dto.dart';

void main() {
  group('MovieResponseDto JSON 매핑 테스트', () {
    test('now_playing_sample.json 매핑 테스트 (dates 포함)', () {
      // JSON 파일 읽기
      final file = File('test/now_playing_sample.json');
      final jsonString = file.readAsStringSync();
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      // DTO 변환
      final dto = MovieResponseDto.fromJson(jsonMap);

      // 검증
      expect(dto.page, 1);
      expect(dto.dates, isNotNull);
      expect(dto.dates?.maximum, '2026-02-04');
      expect(dto.results.isNotEmpty, true);
      expect(dto.results[0].title, '포풍추영');
      expect(dto.results[0].voteAverage, 7.216);
    });

    test('popular_sample.json 매핑 테스트 (dates 미포함)', () {
      final file = File('test/popular_sample.json');
      final jsonString = file.readAsStringSync();
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      final dto = MovieResponseDto.fromJson(jsonMap);

      expect(dto.page, 1);
      expect(dto.dates, isNull);
      expect(dto.results.isNotEmpty, true);
      expect(dto.results[0].title, '주토피아 2');
      expect(dto.totalResults, 1098398);
    });

    test('top_rated_sample.json 매핑 테스트', () {
      final file = File('test/top_rated_sample.json');
      final jsonString = file.readAsStringSync();
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      final dto = MovieResponseDto.fromJson(jsonMap);

      expect(dto.page, 1);
      expect(dto.results[0].title, '쇼생크 탈출');
      expect(dto.results[0].voteAverage, 8.715);
    });

    test('upcoming_sample.json 매핑 테스트 (dates 포함)', () {
      final file = File('test/upcoming_sample.json');
      final jsonString = file.readAsStringSync();
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      final dto = MovieResponseDto.fromJson(jsonMap);

      expect(dto.page, 1);
      expect(dto.dates, isNotNull);
      expect(dto.dates?.maximum, '2026-02-25');
      expect(dto.results[0].title, '그린랜드 2');
    });
  });

  group('MovieDto 개별 필드 타입 안정성 테스트', () {
    test('정수형 vote_average와 popularity가 double로 정상 변환되는지 확인', () {
      final mockJson = {
        "adult": false,
        "backdrop_path": "/path.jpg",
        "genre_ids": [1, 2],
        "id": 123,
        "original_language": "en",
        "original_title": "Original Title",
        "overview": "Overview text",
        "popularity": 100, // int type
        "poster_path": "/poster.jpg",
        "release_date": "2024-01-01",
        "title": "Title",
        "video": false,
        "vote_average": 8, // int type
        "vote_count": 1000,
      };

      final movie = MovieDto.fromJson(mockJson);

      expect(movie.popularity, 100.0);
      expect(movie.voteAverage, 8.0);
      expect(movie.popularity, isA<double>());
      expect(movie.voteAverage, isA<double>());
    });
  });
}

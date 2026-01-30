/// TMDB 영화 API 응답을 처리하기 위한 DTO (Data Transfer Object) 클래스들입니다.
/// Now Playing, Popular, Top Rated, Upcoming의 4가지 API 응답 형식을 모두 수용합니다.

/// 영화 목록 API의 전체 응답을 담는 클래스입니다.
class MovieResponseDto {
  /// 현재 상영 중(Now Playing) 및 개봉 예정(Upcoming) API에서 응답에 포함되는 날짜 범위 정보입니다.
  /// Popular 및 Top Rated API에서는 null일 수 있습니다.
  final DatesDto? dates;

  /// 현재 응답의 페이지 번호입니다.
  final int page;

  /// 영화 목록 데이터입니다.
  final List<MovieDto> results;

  /// 전체 페이지 수입니다.
  final int totalPages;

  /// 전체 검색된 아이템(영화)의 총 개수입니다.
  final int totalResults;

  MovieResponseDto({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  /// JSON 데이터로부터 MovieResponseDto 객체를 생성합니다.
  factory MovieResponseDto.fromJson(Map<String, dynamic> json) {
    return MovieResponseDto(
      dates: json['dates'] != null ? DatesDto.fromJson(json['dates']) : null,
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((item) => MovieDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }

  /// 객체를 JSON 맵 형식으로 변환합니다.
  Map<String, dynamic> toJson() {
    return {
      if (dates != null) 'dates': dates!.toJson(),
      'page': page,
      'results': results.map((movie) => movie.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

/// Now Playing 및 Upcoming API 응답에 포함되는 날짜 범위 정보 클래스입니다.
class DatesDto {
  /// 지정된 범위의 가장 나중 날짜입니다. (YYYY-MM-DD 형식)
  final String maximum;

  /// 지정된 범위의 가장 이른 날짜입니다. (YYYY-MM-DD 형식)
  final String minimum;

  DatesDto({required this.maximum, required this.minimum});

  /// JSON 데이터로부터 DatesDto 객체를 생성합니다.
  factory DatesDto.fromJson(Map<String, dynamic> json) {
    return DatesDto(
      maximum: json['maximum'] as String,
      minimum: json['minimum'] as String,
    );
  }

  /// 객체를 JSON 맵 형식으로 변환합니다.
  Map<String, dynamic> toJson() {
    return {'maximum': maximum, 'minimum': minimum};
  }
}

/// 개별 영화 한 편의 정보를 담는 클래스입니다.
class MovieDto {
  /// 성인용 영화 여부입니다.
  final bool adult;

  /// 영화의 배경(배경 이미지) 이미지 경로입니다.
  final String? backdropPath;

  /// 장르 ID 목록입니다.
  final List<int> genreIds;

  /// 영화의 고유 ID입니다.
  final int id;

  /// 영화의 원본 언어 코드입니다. (예: 'en', 'ko')
  final String originalLanguage;

  /// 영화의 원본 제목입니다.
  final String originalTitle;

  /// 영화의 줄거리 요약입니다.
  final String overview;

  /// 영화의 인기도 점수입니다.
  final double popularity;

  /// 영화의 포스터 이미지 경로입니다.
  final String? posterPath;

  /// 개봉일입니다. (YYYY-MM-DD 형식)
  final String releaseDate;

  /// 영화의 제목(현지화된 제목)입니다.
  final String title;

  /// 비디오 존재 여부입니다.
  final bool video;

  /// 영화의 평점 평균입니다.
  final double voteAverage;

  /// 영화에 대한 총 투표 수입니다.
  final int voteCount;

  MovieDto({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  /// JSON 데이터로부터 MovieDto 객체를 생성합니다.
  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: List<int>.from(json['genre_ids'] as List<dynamic>),
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String,
      // API에 따라 int 또는 double로 올 수 있으므로 안전하게 변환합니다.
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String,
      title: json['title'] as String,
      video: json['video'] as bool,
      // API에 따라 int 또는 double로 올 수 있으므로 안전하게 변환합니다.
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );
  }

  /// 객체를 JSON 맵 형식으로 변환합니다.
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}

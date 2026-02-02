class MovieEntity {
  final int id;
  final String posterImageUrl;

  MovieEntity({required this.id, required this.posterImageUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          posterImageUrl == other.posterImageUrl;

  @override
  int get hashCode => id.hashCode ^ posterImageUrl.hashCode;

  @override
  String toString() {
    return 'MovieEntity{id: $id, posterImageUrl: $posterImageUrl}';
  }
}

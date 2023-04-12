// ignore_for_file: prefer_collection_literals

const String tableSavedShows = 'savedShow';

class SavedShowsFields {
  static final List<String> values = [
    id,
    backdropPath,
    title,
    originalLanguage,
    originalTitle,
    overview,
    posterPath,
    mediaType,
    releaseDate,
    firstAirDate,
    voteCount,
    voteAverage,
    popularity,
    originalName,
    name,
  ];
  static const String id = "id";
  static const String backdropPath = 'backdrop_path';
  static const String title = 'title';
  static const String originalLanguage = 'original_language';
  static const String originalTitle = 'original_title';
  static const String overview = "overview";
  static const String posterPath = 'poster_path';
  static const String mediaType = 'media_type';
  static const String releaseDate = 'release_date';
  static const String firstAirDate = 'first_air_date';
  static const String voteCount = 'vote_count';
  static const String voteAverage = 'vote_average';
  static const String popularity = 'popularity';
  static const String originalName = 'original_name';
  static const String name = 'name';
}

class SavedShows {
  String? backdropPath;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  List<int>? genreIds;
  String? releaseDate;
  String? firstAirDate;
  int? voteCount;
  double? voteAverage;
  double? popularity;
  String? originalName;
  String? name;

  SavedShows({
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.releaseDate,
    this.firstAirDate,
    this.voteCount,
    this.voteAverage,
    this.popularity,
    this.originalName,
    this.name,
  });

  SavedShows copy({
    bool? adult,
    String? backdropPath,
    int? id,
    String? title,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? mediaType,
    String? releaseDate,
    String? firstAirDate,
    bool? video,
    int? voteCount,
    double? voteAverage,
    double? popularity,
    String? originalName,
    String? name,
  }) =>
      SavedShows(
        backdropPath: backdropPath ?? this.backdropPath,
        id: id ?? this.id,
        title: title ?? this.title,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        mediaType: mediaType ?? this.mediaType,
        releaseDate: releaseDate ?? this.releaseDate,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        voteCount: voteCount ?? this.voteCount,
        voteAverage: voteAverage ?? this.voteAverage,
        popularity: popularity ?? this.popularity,
        originalName: originalName ?? this.originalName,
        name: name ?? this.name,
      );

  SavedShows.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    releaseDate = json['release_date'];
    firstAirDate = json['first_air_date'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'] != null ? handleDouble(json['vote_average']) : 0;
    popularity = json['popularity'] != null ? handleDouble(json['popularity']) : 0;
    originalName = json['original_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['title'] = title;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['release_date'] = releaseDate;
    data['first_air_date'] = firstAirDate;
    data['vote_count'] = voteCount;
    data['vote_average'] = voteAverage;
    data['popularity'] = popularity;
    data['original_name'] = originalName;
    data['name'] = name;
    return data;
  }
}

double handleDouble(dynamic val) {
  if (val is int || val is double) {
    return val.toDouble();
  } else {
    return double.parse(val);
  }
}

// ignore_for_file: prefer_collection_literals

class Shows {
  bool? adult;
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
  bool? video;
  int? voteCount;
  double? voteAverage;
  double? popularity;
  String? originalName;
  String? name;

  Shows(
      {this.adult,
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
      this.video,
      this.voteCount,
      this.voteAverage,
      this.popularity,
      this.originalName,
      this.name});

  Shows.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    releaseDate = json['release_date'];
    firstAirDate = json['first_air_date'];
    video = json['video'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'] != null ? json['vote_average'].toDouble() : 0;
    popularity = json['popularity'] != null ? json['popularity'].toDouble() : 0;
    originalName = json['original_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['title'] = title;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['genre_ids'] = genreIds;
    data['release_date'] = releaseDate;
    data['first_air_date'] = firstAirDate;
    data['video'] = video;
    data['vote_count'] = voteCount;
    data['vote_average'] = voteAverage;
    data['popularity'] = popularity;
    data['original_name'] = originalName;
    data['name'] = name;
    return data;
  }
}

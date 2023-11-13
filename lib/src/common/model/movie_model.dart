import 'package:flutter/foundation.dart';

@immutable
class MovieModel {
  const MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieModel.fromJson(Map<String, Object?> json) => MovieModel(
    adult: (json['adult'] as bool?)!,
    backdropPath: (json['backdrop_path'] as String?),
    genreIds: json['genre_ids'] != null ? List<int>.from((json['genre_ids'] as List?)!) : [],
    id: (json['id'] as int?)!,
    originalLanguage: (json['original_language'] as String?)!,
    originalTitle: (json['original_title'] as String?)!,
    overview: (json['overview'] as String?)!,
    popularity: (json['popularity'] as double?)!,
    posterPath: (json['poster_path'] as String?),
    releaseDate: (json['release_date'] as String?)!,
    title: (json['title'] as String?)!,
    video: (json['video'] as bool?)!,
    voteAverage: double.parse((json['vote_average'] as num?)!.toString()),
    voteCount: (json['vote_count'] as int?)!,
  );

  Map<String, Object?> toJson() => {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MovieModel &&
              runtimeType == other.runtimeType &&
              adult == other.adult &&
              backdropPath == other.backdropPath &&
              genreIds == other.genreIds &&
              id == other.id &&
              originalLanguage == other.originalLanguage &&
              originalTitle == other.originalTitle &&
              overview == other.overview &&
              popularity == other.popularity &&
              posterPath == other.posterPath &&
              releaseDate == other.releaseDate &&
              title == other.title &&
              video == other.video &&
              voteAverage == other.voteAverage &&
              voteCount == other.voteCount;

  @override
  int get hashCode =>
      adult.hashCode ^
      backdropPath.hashCode ^
      genreIds.hashCode ^
      id.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      title.hashCode ^
      video.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode;

  @override
  String toString() {
    return 'MovieModel('
        'adult: $adult, '
        'backdropPath: $backdropPath, '
        'genreIds: $genreIds, '
        'id: $id, '
        'originalLanguage: $originalLanguage, '
        'originalTitle: $originalTitle, '
        'overview: $overview, '
        'popularity: $popularity, '
        'posterPath: $posterPath, '
        'releaseDate: $releaseDate, '
        'title: $title, '
        'video: $video, '
        'voteAverage: $voteAverage, '
        'voteCount: $voteCount)';
  }
}

/*
{
"adult": false,
"backdropPath": "/5QEtCBM6aXHftr7sgFxxUUl9Ej8.jpg",
"genreIds": [
80,
18,
53,
28
],
"id": 75780,
"originalLanguage": "en",
"originalTitle": "Jack Reacher",
"overview": "When a gunman takes five lives with six shots, all evidence points to the suspect in custody. On interrogation, the suspect offers up a single note: \"Get Jack Reacher!\" So begins an extraordinary chase for the truth, pitting Jack Reacher against an unexpected enemy, with a skill for violence and a secret to keep.",
"popularity": 41.105,
"posterPath": "/uQBbjrLVsUibWxNDGA4Czzo8lwz.jpg",
"releaseDate": "2012-12-20",
"title": "Jack Reacher",
"video": false,
"voteAverage": 6.609,
"voteCount": 6517
}
*/

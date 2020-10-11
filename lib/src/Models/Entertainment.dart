import 'package:equatable/equatable.dart';
import 'package:flutter_movie/src/Utils.dart';

class Entertainment extends Equatable {
  final String posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<dynamic> genreIds;
  final int id;
  final String title;
  final String originalTitle;
  final num popularity;
  final num voteCount;
  final bool video;
  final num voteAverage;

  const Entertainment({
    this.id,
    this.posterPath,
    this.adult,
    this.title,
    this.originalTitle,
    this.genreIds,
    this.overview,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteCount,
    this.voteAverage,
  });

  static Entertainment fromJsonToMovie(Map<String, dynamic> json) {
    return Entertainment(
      title: json['title'],
      originalTitle: json["original_title"],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      adult: json['adult'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      genreIds: json['genre_ids'],
      id: json['id'],
      voteCount: json['vote_count'],
      video: json['video'],
      voteAverage: json['vote_average'],
    );
  }

  static Entertainment fromJsonToTVShow(Map<String, dynamic> json) {
    return Entertainment(
      title: json['name'],
      originalTitle: json["original_name"],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      adult: json['adult'],
      overview: json['overview'],
      releaseDate: json['first_air_date'],
      genreIds: json['genre_ids'],
      id: json['id'],
      voteCount: json['vote_count'],
      voteAverage: json['vote_average'],
    );
  }

  String getPoster() =>
      posterPath != null ? AppUtils.buildImagePath(posterPath, size: EImageSize.w92) : null;

  @override
  List<Object> get props => [
        posterPath,
        adult,
        overview,
        releaseDate,
        genreIds,
        id,
        title,
        originalTitle,
        popularity,
        voteCount,
        video,
        voteAverage
      ];
}

enum EEntertainmentType { TV, Movie }

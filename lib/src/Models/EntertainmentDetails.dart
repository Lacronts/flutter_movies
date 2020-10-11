import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Models/Genre.dart';
import 'package:flutter_movie/src/Utils.dart';

class EntertainmentDetails extends Equatable {
  final String backdropPath;
  final int budget;
  final List<String> genres;
  final int id;
  final String imdbId;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<String> productionCountries;
  final List<String> directors;

  const EntertainmentDetails({
    this.id,
    this.imdbId,
    this.title,
    this.releaseDate,
    this.genres,
    this.backdropPath,
    this.voteCount,
    this.voteAverage,
    this.overview,
    this.popularity,
    this.posterPath,
    this.video,
    this.budget,
    this.originalTitle,
    this.revenue,
    this.runtime,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.productionCountries,
    this.directors,
  });

  static EntertainmentDetails fromJsonToMovie(Map<String, dynamic> json) {
    final List productionCountries = json["production_countries"] ?? [];

    return EntertainmentDetails(
      id: json["id"],
      imdbId: json["imdb_id"],
      title: json["title"],
      releaseDate: json["release_date"],
      genres: (json["genres"] as List).map((genre) => Genre.fromJson(genre).name).toList(),
      backdropPath: json["backdrop_path"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      popularity: json["popularity"],
      video: json["video"],
      budget: json["budget"],
      originalTitle: json["original_title"],
      revenue: json["revenue"],
      runtime: json["runtime"],
      productionCountries: productionCountries.map((country) => country["name"] as String).toList(),
      directors: [],
    );
  }

  static EntertainmentDetails fromJsonToTV(dynamic json) {
    final List directors = json["created_by"] ?? [];
    final List productionCountries = json["origin_country"] ?? [];

    return EntertainmentDetails(
      id: json["id"],
      title: json["name"],
      releaseDate: json["first_air_date"],
      genres: (json["genres"] as List).map((genre) => Genre.fromJson(genre).name).toList(),
      backdropPath: json["backdrop_path"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      popularity: json["popularity"],
      originalTitle: json["original_name"],
      runtime: json["episode_run_time"][0],
      numberOfSeasons: json["number_of_seasons"],
      numberOfEpisodes: json["number_of_episodes"],
      productionCountries: productionCountries.map((country) => country as String).toList(),
      directors: directors.map((director) => director["name"] as String).toList(),
    );
  }

  String getBackdrop() =>
      backdropPath != null ? AppUtils.buildImagePath(backdropPath, size: EImageSize.w780) : null;

  String getPoster() => posterPath != null ? AppUtils.buildImagePath(posterPath) : null;

  @override
  List<Object> get props => [
        id,
        imdbId,
        title,
        releaseDate,
        genres,
        backdropPath,
        voteCount,
        voteAverage,
        overview,
        popularity,
        posterPath,
        video,
        budget,
        originalTitle,
        revenue,
        runtime,
        productionCountries,
        numberOfSeasons,
        numberOfEpisodes,
        directors,
      ];
}

class DetailsArguments extends Equatable {
  final int id;
  final String title;
  final EEntertainmentType type;

  const DetailsArguments({
    @required this.id,
    @required this.title,
    @required this.type,
  });

  @override
  List<Object> get props => [id, title, type];
}

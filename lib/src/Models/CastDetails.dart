import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const AVAILABLE_ASPECT_RATIO = '0.67';

class CastDetails extends Equatable {
  final num id;
  final String birthday;
  final String knownForDepartment;
  final String name;
  final String biography;
  final String placeOfBirth;
  final String profilePath;
  final String imdbId;
  final String homePage;

  const CastDetails({
    this.id,
    this.name,
    this.profilePath,
    this.biography,
    this.birthday,
    this.homePage,
    this.imdbId,
    this.knownForDepartment,
    this.placeOfBirth,
  });

  static CastDetails fromJson(Map<String, dynamic> json) {
    return CastDetails(
      id: json['id'],
      birthday: json['birthday'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      biography: json['biography'],
      placeOfBirth: json['place_of_birth'],
      profilePath: json['profile_path'],
      imdbId: json['imdb_id'],
      homePage: json['home_page'],
    );
  }

  @override
  List<Object> get props => [
        id,
        birthday,
        knownForDepartment,
        name,
        biography,
        placeOfBirth,
        profilePath,
        imdbId,
        homePage
      ];
}

class CastArguments extends Equatable {
  final String castName;
  final int castId;

  const CastArguments({@required this.castName, @required this.castId});

  @override
  List<Object> get props => [castId, castName];
}

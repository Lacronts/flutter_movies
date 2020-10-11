import 'package:equatable/equatable.dart';

const MAX_NUMBERS_OF_ACTORS = 30;

class Actor extends Equatable {
  final int castId;
  final int id;
  final String character;
  final String name;
  final String profilePath;

  const Actor({
    this.id,
    this.castId,
    this.character,
    this.name,
    this.profilePath,
  });

  static Actor fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      castId: json['cast_id'],
      character: json['character'],
      name: json['name'],
      profilePath: json['profile_path'],
    );
  }

  @override
  List<Object> get props => [id, castId, character, name, profilePath];
}

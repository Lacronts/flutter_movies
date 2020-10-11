import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;

  Genre({
    this.id,
    this.name,
  });

  static Genre fromJson(dynamic json) {
    return Genre(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  List<Object> get props => [id, name];
}

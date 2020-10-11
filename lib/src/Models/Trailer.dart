import 'package:equatable/equatable.dart';

const TrailerType = 'Trailer';
const AvailableSite = 'YouTube';

class Trailer extends Equatable {
  final String id;
  final String site;
  final String key;

  const Trailer({
    this.id,
    this.key,
    this.site,
  });

  static Trailer fromJson(dynamic json) {
    if (json == null) return null;
    return Trailer(
      id: json['id'],
      site: json['site'],
      key: json['key'],
    );
  }

  @override
  List<Object> get props => [id, site, key];
}

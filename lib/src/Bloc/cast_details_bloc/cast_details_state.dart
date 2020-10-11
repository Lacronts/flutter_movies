import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/src/Models/CastDetails.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';

abstract class CastDetailsState extends Equatable {
  const CastDetailsState();

  @override
  List<Object> get props => [];
}

class CastDetailsLoadedInProgress extends CastDetailsState {}

class CastDetailsLoadedSuccess extends CastDetailsState {
  final CastDetails castDetails;
  final List<String> personImages;
  final List<Entertainment> filmography;
  final List<Entertainment> tvShows;

  const CastDetailsLoadedSuccess({
    @required this.castDetails,
    @required this.personImages,
    @required this.filmography,
    @required this.tvShows,
  });

  @override
  List<Object> get props => [castDetails, personImages, filmography, tvShows];
}

class CastDetailsLoadedFailure extends CastDetailsState {
  final Error err;

  const CastDetailsLoadedFailure(this.err);

  @override
  List<Object> get props => [err];

  @override
  String toString() {
    return 'cast details err: $err';
  }
}

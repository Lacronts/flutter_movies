import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie/src/Models/CastDetails.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';

import './bloc.dart';

class CastDetailsBloc extends Bloc<CastDetailsEvent, CastDetailsState> {
  final MovieRepositories movieRepositories;

  CastDetailsBloc(this.movieRepositories):super(CastDetailsLoadedInProgress());

  @override
  Stream<CastDetailsState> mapEventToState(
    CastDetailsEvent event,
  ) async* {
    if (event is CastDetailsLoaded) {
      yield* _mapCastDetailsLoadedToState(event);
    }
  }

  Stream<CastDetailsState> _mapCastDetailsLoadedToState(CastDetailsLoaded event) async* {
    try {
      final List responses = await Future.wait([
        movieRepositories.getCastDetailsByCastId(event.castId),
        movieRepositories.getPersonImagesByCastId(event.castId),
        movieRepositories.getMovieCreditsByCastId(event.castId),
        movieRepositories.getTVCreditsByCastId(event.castId),
      ]);

      final images = List<Map<String, dynamic>>.from(responses[1]);

      final List<String> filteredImages = images
          // .where((image) =>
          //     (image['aspect_ratio'] as num).toStringAsFixed(2) == AVAILABLE_ASPECT_RATIO)
          .map((image) => image['file_path'] as String)
          .toList();

      final List<Entertainment> filmography = List<Map<String, dynamic>>.from(responses[2])
          .map((movie) => Entertainment.fromJsonToMovie(movie))
          .where((movie) => movie.posterPath != null && movie.title != null)
          .toList();

      final List<Entertainment> tvShows = List<Map<String, dynamic>>.from(responses[3])
          .map((movie) => Entertainment.fromJsonToTVShow(movie))
          .where((movie) => movie.posterPath != null && movie.title != null)
          .toList();

      yield CastDetailsLoadedSuccess(
        castDetails: CastDetails.fromJson(responses[0]),
        personImages: filteredImages,
        filmography: filmography,
        tvShows: tvShows,
      );
    } catch (err) {
      print(err);
      yield CastDetailsLoadedFailure(err);
    }
  }
}

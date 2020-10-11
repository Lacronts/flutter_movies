import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Models/EntertainmentDetails.dart';
import 'package:flutter_movie/src/Models/Review.dart';
import 'package:flutter_movie/src/Models/Trailer.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final MovieRepositories movieRepositories;

  DetailsBloc(this.movieRepositories) : super(DetailsLoadedInProgress());

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is DetailsLoaded) {
      yield* _mapDetailsLoadedToState(event);
    } else if (event is ResetDetails) {
      yield* _mapResetDetailsToState();
    }
  }

  Stream<DetailsState> _mapDetailsLoadedToState(DetailsLoaded event) async* {
    try {
      final List responses = await Future.wait([
        movieRepositories.getEntertainmentDetailsById(
            id: event.entertainmentId, type: event.type),
        movieRepositories.getTrailerById(
            id: event.entertainmentId, type: event.type),
        movieRepositories.getUserReviewsById(
            id: event.entertainmentId, type: event.type),
        movieRepositories.getRecommendationsById(
            id: event.entertainmentId, type: event.type),
      ]);

      final dynamic trailer = (responses[1] as List<dynamic>).firstWhere(
          (item) =>
              item['type'] == TrailerType && item['site'] == AvailableSite,
          orElse: () => null);

      final List<Review> reviews = (responses[2] as List)
          .map((review) => Review.fromJson(review))
          .toList();

      final List<Entertainment> recommendations = (responses[3] as List)
          .map(
            (entertainment) => event.type == EEntertainmentType.Movie
                ? Entertainment.fromJsonToMovie(entertainment)
                : Entertainment.fromJsonToTVShow(entertainment),
          ).where((entertainment) => entertainment.posterPath != null)
          .toList();

      yield DetailsLoadedSuccess(
        details: event.type == EEntertainmentType.Movie
            ? EntertainmentDetails.fromJsonToMovie(responses[0])
            : EntertainmentDetails.fromJsonToTV(responses[0]),
        trailer: Trailer.fromJson(trailer),
        reviews: reviews,
        recommendations: recommendations,
      );
    } catch (err) {
      print(err);
      yield DetailsLoadedFailure();
    }
  }

  Stream<DetailsState> _mapResetDetailsToState() async* {
    yield DetailsLoadedInProgress();
  }
}

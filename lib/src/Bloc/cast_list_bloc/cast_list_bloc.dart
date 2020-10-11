import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie/src/Models/Actor.dart';
import 'package:flutter_movie/src/Models/EntertainmentCrew.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';

import './bloc.dart';

class CastListBloc extends Bloc<CastListBlocEvent, CastListBlocState> {
  final MovieRepositories movieRepositories;

  CastListBloc(this.movieRepositories) : super(CastListLoadedInProgress());

  @override
  Stream<CastListBlocState> mapEventToState(
    CastListBlocEvent event,
  ) async* {
    if (event is CastListLoaded) {
      yield* _mapCastLoadedToState(event);
    }
  }

  Stream<CastListBlocState> _mapCastLoadedToState(CastListLoaded event) async* {
    try {
      final Map<String, dynamic> json =
          await movieRepositories.getCastsByEntertainmentId(
        id: event.entertainmentId,
        type: event.type,
      );

      final List<EntertainmentCrew> crew = (json['crew'] as List<dynamic>)
          .map((person) => EntertainmentCrew.fromJson(person))
          .toList();

      final topCasts = (json['cast'] as List<dynamic>)
          .map((cast) => Actor.fromJson(cast))
          .where((cast) => cast.profilePath != null && cast.character != null)
          .toList();

      yield CastListLoadedSuccess(actors: topCasts, crew: crew);
    } catch (err) {
      print(err);
      yield CastListLoadedFailure();
    }
  }
}

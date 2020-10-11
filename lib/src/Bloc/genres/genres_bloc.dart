import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Genre.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';

part 'genres_event.dart';
part 'genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final MovieRepositories moviesRepository;

  GenresBloc(this.moviesRepository) : super(GenresLoadedInProgress());

  @override
  Stream<GenresState> mapEventToState(
    GenresEvent event,
  ) async* {
    if (event is GenresLoaded) {
      yield* _mapGenresLoadedToState();
    }
  }

  Stream<GenresState> _mapGenresLoadedToState() async* {
    try {
      final json = await moviesRepository.loadGenres();
      yield GenresLoadedSuccess(
        items: json.map((genre) => Genre.fromJson(genre)).toList(),
      );
    } catch (err) {
      print(err);
      yield GenresLoadedFailure();
    }
  }
}

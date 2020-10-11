import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final MovieRepositories moviesRepository;

  TopRatedBloc({@required this.moviesRepository})
      : super(TopRatedLoadedInProgress());

  @override
  Stream<TopRatedState> mapEventToState(
    TopRatedEvent event,
  ) async* {
    if (event is TopRatedLoaded) {
      yield* _mapTopRatedLoadedToState();
    } else if (event is TopRatedLoadedLazy) {
      yield* _mapTopRatedLoadedLazyToState();
    }
  }

  Stream<TopRatedState> _mapTopRatedLoadedToState() async* {
    try {
      final List<dynamic> json = await moviesRepository.loadTopRated();

      final movies =
          json.map((movie) => Entertainment.fromJsonToMovie(movie)).toList();
      yield TopRatedLoadSuccess(movies: movies);
    } catch (err) {
      yield TopRatedLoadFailure(err);
    }
  }

  Stream<TopRatedState> _mapTopRatedLoadedLazyToState() async* {
    try {
      if (state is TopRatedLoadSuccess) {
        final currentState = state as TopRatedLoadSuccess;
        final nextPage = currentState.page + 1;
        final List<dynamic> json =
            await moviesRepository.loadTopRated(page: nextPage);
        final movies =
            json.map((movie) => Entertainment.fromJsonToMovie(movie)).toList();
        yield TopRatedLoadSuccess(
            movies: [...currentState.movies, ...movies], page: nextPage);
      }
    } catch (err) {
      print(err);
    }
  }
}

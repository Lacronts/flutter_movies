import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final MovieRepositories moviesRepository;

  NowPlayingBloc({@required this.moviesRepository})
      : super(NowPlayingLoadedInProgress());

  @override
  Stream<NowPlayingState> mapEventToState(
    NowPlayingEvent event,
  ) async* {
    if (event is NowPlayingLoaded) {
      yield* _mapNowPlayingLoadedToState();
    } else if (event is NowPlayingLoadedLazy) {
      yield* _mapNowPlayingLoadedLazyToState();
    }
  }

  Stream<NowPlayingState> _mapNowPlayingLoadedToState() async* {
    try {
      final json = await moviesRepository.loadNowPlaying();

      final nowPlayingMovies =
          json.map((movie) => Entertainment.fromJsonToMovie(movie)).toList();
      yield NowPlayingLoadSuccess(movies: nowPlayingMovies);
    } catch (err) {
      yield NowPlayingLoadFailure(err);
    }
  }

  Stream<NowPlayingState> _mapNowPlayingLoadedLazyToState() async* {
    try {
      if (state is NowPlayingLoadSuccess) {
        final currentState = state as NowPlayingLoadSuccess;
        final nextPage = currentState.page + 1;
        final json = await moviesRepository.loadNowPlaying(page: nextPage);

        final movies =
            json.map((movie) => Entertainment.fromJsonToMovie(movie)).toList();

        yield NowPlayingLoadSuccess(
          movies: [...currentState.movies, ...movies],
          page: nextPage,
        );
      }
    } catch (err) {
      print(err);
    }
  }
}

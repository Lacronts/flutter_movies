import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final MovieRepositories moviesRepository;

  UpcomingBloc({@required this.moviesRepository})
      : super(UpcomingLoadedInProgress());

  @override
  Stream<UpcomingState> mapEventToState(
    UpcomingEvent event,
  ) async* {
    if (event is UpcomingLoaded) {
      yield* _mapUpcomingLoadedToState();
    } else if (event is UpcomingLoadedLazy) {
      yield* _mapUpcomingLoadedLazyToState();
    }
  }

  Stream<UpcomingState> _mapUpcomingLoadedToState() async* {
    try {
      final json = await moviesRepository.loadUpcomingMovies();

      final upcomingMovies = json
          .map((movie) => Entertainment.fromJsonToMovie(movie))
          .where((movie) => movie.posterPath.isNotEmpty)
          .toList();
      yield UpcomingLoadSuccess(movies: upcomingMovies);
    } catch (err) {
      yield UpcomingLoadFailure(err);
    }
  }

  Stream<UpcomingState> _mapUpcomingLoadedLazyToState() async* {
    try {
      if (state is UpcomingLoadSuccess) {
        final currentState = state as UpcomingLoadSuccess;
        final nextPage = currentState.page + 1;
        final json = await moviesRepository.loadUpcomingMovies(page: nextPage);

        final upcomingMovies = json
            .map((movie) => Entertainment.fromJsonToMovie(movie))
            .where((movie) => movie.posterPath.isNotEmpty)
            .toList();

        yield UpcomingLoadSuccess(
          movies: [...currentState.movies, ...upcomingMovies],
          page: nextPage,
        );
      }
    } catch (err) {
      print(err);
    }
  }
}

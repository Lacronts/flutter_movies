import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';

import './bloc.dart';

class EntertainmentImagesBloc
    extends Bloc<EntertainmentImagesEvent, EntertainmentImagesState> {
  final MovieRepositories moviesRepository;

  EntertainmentImagesBloc(this.moviesRepository)
      : super(EntertainmentImagesLoadedInProgress());

  @override
  Stream<EntertainmentImagesState> mapEventToState(
    EntertainmentImagesEvent event,
  ) async* {
    if (event is EntertainmentImagesLoaded) {
      yield* _mapMovieImagesLoadedToState(event);
    }
  }

  Stream<EntertainmentImagesState> _mapMovieImagesLoadedToState(
      EntertainmentImagesLoaded event) async* {
    try {
      final json = await moviesRepository.getEntertainmentImagesById(
        id: event.entertainmentId,
        type: event.type,
      );
      final List<String> images = json
          //.where((image) => image['aspect_ratio'].toStringAsFixed(2) == '1.78')
          .map((image) => '${image['file_path']}')
          .toList();
      yield EntertainmentImagesLoadedSuccess(images,
          entertainmentId: event.entertainmentId);
    } catch (err) {
      yield EntertainmentImagesLoadedFailure(err);
    }
  }
}

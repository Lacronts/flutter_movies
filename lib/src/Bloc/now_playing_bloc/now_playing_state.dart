part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingLoadedInProgress extends NowPlayingState {}

class NowPlayingLoadSuccess extends NowPlayingState {
  final List<Entertainment> movies;
  final int page;

  const NowPlayingLoadSuccess({@required this.movies, this.page = 1});

  @override
  List<Object> get props => [movies, page];
}

class NowPlayingLoadFailure extends NowPlayingState {
  final Error err;
  const NowPlayingLoadFailure(this.err);

  @override
  String toString() => err.toString();
}

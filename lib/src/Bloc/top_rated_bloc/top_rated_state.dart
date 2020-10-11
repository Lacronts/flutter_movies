part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedLoadedInProgress extends TopRatedState {}

class TopRatedLoadSuccess extends TopRatedState {
  final List<Entertainment> movies;
  final int page;

  const TopRatedLoadSuccess({@required this.movies, this.page = 1});

  @override
  List<Object> get props => [movies, page];
}

class TopRatedLoadFailure extends TopRatedState {
  final Error err;
  const TopRatedLoadFailure(this.err);

  @override
  String toString() => err.toString();
}

part of 'upcoming_bloc.dart';

abstract class UpcomingState extends Equatable {
  const UpcomingState();

  @override
  List<Object> get props => [];
}

class UpcomingLoadedInProgress extends UpcomingState {}

class UpcomingLoadSuccess extends UpcomingState {
  final List<Entertainment> movies;
  final int page;

  const UpcomingLoadSuccess({@required this.movies, this.page = 1});

  @override
  List<Object> get props => [movies, page];
}

class UpcomingLoadFailure extends UpcomingState {
  final Error err;
  const UpcomingLoadFailure(this.err);

  @override
  String toString() => err.toString();
}

part of 'genres_bloc.dart';

abstract class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object> get props => [];
}

class GenresLoadedInProgress extends GenresState {}

class GenresLoadedSuccess extends GenresState {
  final List<Genre> items;

  GenresLoadedSuccess({@required this.items});

  @override
  List<Object> get props => [items];
}

class GenresLoadedFailure extends GenresState {}

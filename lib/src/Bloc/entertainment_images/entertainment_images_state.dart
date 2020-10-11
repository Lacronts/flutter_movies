import 'package:equatable/equatable.dart';

abstract class EntertainmentImagesState extends Equatable {
  const EntertainmentImagesState();

  @override
  List<Object> get props => [];
}

class EntertainmentImagesLoadedInProgress extends EntertainmentImagesState {}

class EntertainmentImagesLoadedSuccess extends EntertainmentImagesState {
  final List<String> images;
  final int entertainmentId;

  const EntertainmentImagesLoadedSuccess(this.images, {this.entertainmentId});

  @override
  List<Object> get props => [images, entertainmentId];
}

class EntertainmentImagesLoadedFailure extends EntertainmentImagesState {
  final Exception err;

  const EntertainmentImagesLoadedFailure(this.err);

  @override
  List<Object> get props => [err];

  @override
  String toString() => 'movie images err: $err';
}

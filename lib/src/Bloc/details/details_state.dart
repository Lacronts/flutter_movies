part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsLoadedInProgress extends DetailsState {}

class DetailsLoadedSuccess extends DetailsState {
  final EntertainmentDetails details;
  final Trailer trailer;
  final List<Review> reviews;
  final List<Entertainment> recommendations;

  DetailsLoadedSuccess({
    @required this.details,
    @required this.trailer,
    @required this.reviews,
    @required this.recommendations,
  });

  @override
  List<Object> get props => [details, trailer, reviews, recommendations];
}

class DetailsLoadedFailure extends DetailsState {}

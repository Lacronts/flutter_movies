part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class DetailsLoaded extends DetailsEvent {
  final int entertainmentId;
  final EEntertainmentType type;

  const DetailsLoaded({
    @required this.entertainmentId,
    @required this.type,
  });

  @override
  List<Object> get props => [entertainmentId, type];
}

class ResetDetails extends DetailsEvent {}

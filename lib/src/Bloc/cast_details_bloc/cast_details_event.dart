import 'package:equatable/equatable.dart';

abstract class CastDetailsEvent extends Equatable {
  const CastDetailsEvent();
}

class CastDetailsLoaded extends CastDetailsEvent {
  final int castId;

  const CastDetailsLoaded(this.castId);

  @override
  List<Object> get props => [castId];
}

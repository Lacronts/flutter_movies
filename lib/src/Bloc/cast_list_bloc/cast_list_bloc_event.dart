import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';

abstract class CastListBlocEvent extends Equatable {
  const CastListBlocEvent();
}

class CastListLoaded extends CastListBlocEvent {
  final int entertainmentId;
  final EEntertainmentType type;

  const CastListLoaded({
    @required this.entertainmentId,
    @required this.type,
  });

  @override
  List<Object> get props => [entertainmentId, type];
}

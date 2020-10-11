import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';

abstract class EntertainmentImagesEvent extends Equatable {
  const EntertainmentImagesEvent();

  @override
  List<Object> get props => [];
}

class EntertainmentImagesLoaded extends EntertainmentImagesEvent {
  final int entertainmentId;
  final EEntertainmentType type;

  const EntertainmentImagesLoaded({
    @required this.entertainmentId,
    @required this.type,
  });

  @override
  List<Object> get props => [entertainmentId, type];
}

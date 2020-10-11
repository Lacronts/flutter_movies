import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Actor.dart';
import 'package:flutter_movie/src/Models/EntertainmentCrew.dart';

abstract class CastListBlocState extends Equatable {
  const CastListBlocState();

  @override
  List<Object> get props => [];
}

class CastListLoadedInProgress extends CastListBlocState {}

class CastListLoadedSuccess extends CastListBlocState {
  final List<Actor> actors;
  final List<EntertainmentCrew> crew;

  const CastListLoadedSuccess({
    @required this.actors,
    @required this.crew,
  });

  @override
  List<Object> get props => [actors, crew];
}

class CastListLoadedFailure extends CastListBlocState {}

import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdated extends CharacterEvent {
  const FilterUpdated({required this.filter});

  final String filter;

  @override
  List<Object> get props => [filter];
}

class AppStarted extends CharacterEvent {}

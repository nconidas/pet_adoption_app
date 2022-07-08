part of 'adoptable_pets_bloc.dart';

@immutable
abstract class AdoptablePetsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AdoptablePetsInitial extends AdoptablePetsState {}

class Loading extends AdoptablePetsState {
  @override
  List<Object> get props => [];
}

class Loaded extends AdoptablePetsState {
  final AdoptablePets adoptablePets;
  Loaded({required this.adoptablePets});

  @override
  List<Object> get props => [adoptablePets];
}

class Error extends AdoptablePetsState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
